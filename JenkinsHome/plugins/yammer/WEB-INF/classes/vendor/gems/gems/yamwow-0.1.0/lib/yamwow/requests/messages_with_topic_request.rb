require 'time'
require_relative '../response'
require_relative 'topic_with_name_request'

module YamWow
  class MessagesWithTopicRequest

    def initialize(client, topic_name, options={})
      @client = client
      @topic_name = topic_name
      @options = options
    end

    def send
      @messages = []
      @references = []
      loop_finished = topic_id.nil?

      until loop_finished
        response_data = send_messages_request
        before_message_count = @messages.length
        add_messages response_data['messages'], response_data['references']
        after_message_count = @messages.length
        no_more_messages = before_message_count == after_message_count
        loop_finished = no_more_messages || limit_reached
      end

      @messages.sort! { |x, y| Time.parse(y['created_at']) <=> Time.parse(x['created_at']) }

      Response.new @messages, @references
    end

    private

    def send_messages_request
      @client.get_messages "about_topic/#{topic_id}.json", threaded: true, older_than: oldest_message_id
    end

    def topic_id
      @topic_id ||= get_topic_id
    end

    def get_topic_id
      request = TopicWithNameRequest.new @client, @topic_name
      response = request.send
      topic = response.data
      topic.id if topic
    end

    def oldest_message_id
      sorted_messages = @messages.sort { |x, y| Time.parse(y['created_at']) <=> Time.parse(x['created_at']) }
      last_message = sorted_messages.last
      last_message.id if last_message
    end

    def add_messages(messages_data, reference_data)
      @messages += build_messages messages_data, reference_data
      @messages = @messages[0..limit_count-1] if limit_count > 0
      @references += reference_data
    end

    def build_messages(messages_data, reference_data)
      messages_data.select { |m| m['replied_to_id'].nil? }.each do |m|
        m['like_count'] = m['liked_by']['count'].to_i
        m['sender_tag'] = "[[user:#{m['sender_id']}]]"
      end
    end

    def limit_reached
      limit_count > 0 ? @messages.length == limit_count : false
    end

    def limit_count
      @options[:limit_count] ? @options[:limit_count].to_i : 0
    end

  end
end