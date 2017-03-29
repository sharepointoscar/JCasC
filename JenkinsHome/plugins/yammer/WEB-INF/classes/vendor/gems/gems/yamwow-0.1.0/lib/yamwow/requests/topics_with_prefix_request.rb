require_relative '../response'
require_relative 'topic_with_id_request'

module YamWow
  class TopicsWithPrefixRequest

    def initialize(client, topic_prefix, options={})
      @client = client
      @topic_prefix = topic_prefix
      @detailed = options[:detailed]
    end

    def send
      topics = get_topics
      topics.each { |t| add_details t } if @detailed
      Response.new topics
    end

    private

    def get_topics
      response = @client.get_autocomplete(prefix: @topic_prefix)
      response['topics'] || []
    end

    def add_details(topic)
      r = get_detailed_topic topic['id']
      topic.merge! r.data
    end

    def get_detailed_topic(topic_id)
      TopicWithIdRequest.new(@client, topic_id).send
    end

  end
end