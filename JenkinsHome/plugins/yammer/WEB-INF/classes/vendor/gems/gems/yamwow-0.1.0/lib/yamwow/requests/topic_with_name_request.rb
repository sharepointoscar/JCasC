require_relative '../response'
require_relative 'topics_with_prefix_request'

module YamWow
  class TopicWithNameRequest

    def initialize(client, topic_name, options={})
      @client = client
      @topic_name = topic_name
      @detailed = options[:detailed]
    end

    def send
      topics = get_topics
      topic = first_topic_with_matching_name topics
      Response.new topic
    end

    private

    def get_topics
      response = TopicsWithPrefixRequest.new(@client, @topic_name, detailed: @detailed).send
      response.data || []
    end

    def first_topic_with_matching_name(topics)
      topics.select { |t| t['name'].casecmp(@topic_name) == 0 }.first
    end

  end
end