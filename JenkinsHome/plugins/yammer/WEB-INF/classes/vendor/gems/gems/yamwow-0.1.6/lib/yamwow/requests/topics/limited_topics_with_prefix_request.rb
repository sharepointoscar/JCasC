module YamWow
  class LimitedTopicsWithPrefixRequest

    LIMIT = 50

    def initialize(client, responder)
      @client = client
      @responder = responder
    end

    def send(topic_prefix)
      @topic_prefix = topic_prefix
      @responder.create_response topics
    end

    private

    def topics
      data = @client.get_autocomplete prefix: @topic_prefix
      data['topics'] || []
    end

  end
end