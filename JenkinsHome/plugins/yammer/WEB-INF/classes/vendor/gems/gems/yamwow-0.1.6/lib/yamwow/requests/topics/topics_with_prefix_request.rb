module YamWow
  class TopicsWithPrefixRequest

    def initialize(responder, limited_topics_with_prefix_request)
      @responder = responder
      @limited_topics_with_prefix_request = limited_topics_with_prefix_request
    end

    def send(topic_prefix)
      @topic_prefix = topic_prefix
      @topics = []
      add_topics(@topic_prefix) { find_topics @topic_prefix }
      @responder.create_response @topics
    end

    private

    def find_topics(prefix)
      range.each do |suffix|
        next_prefix = prefix + suffix
        add_topics(next_prefix) { find_topics next_prefix }
      end
    end

    def range
      first_char = @topic_prefix[0]
      first_char.to_i.to_s == first_char ? ('0'..'9') : ('a'..'z')
    end

    def add_topics(prefix)
      response = @limited_topics_with_prefix_request.send prefix
      topics = response.data || []
      yield if topics.length == LimitedTopicsWithPrefixRequest::LIMIT
      @topics += [topics].flatten
    end

  end
end


