module YamWow
  class TopicWithNameRequest

    def initialize(topics_with_prefix_request)
      @topics_with_prefix_request = topics_with_prefix_request
    end

    def send(topic_name)
      @topic_name = topic_name
      Response.new topic_with_name
    end

    private

    def topic_with_name
      topics_with_prefix.select { |t| t['name'].casecmp(@topic_name) == 0 }.first
    end

    def topics_with_prefix
      response = @topics_with_prefix_request.send @topic_name
      response.data || []
    end

  end
end