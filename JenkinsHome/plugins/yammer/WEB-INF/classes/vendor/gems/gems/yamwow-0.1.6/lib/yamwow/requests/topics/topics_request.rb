module YamWow
  class TopicsRequest

    def initialize(responder, topics_with_prefix_request)
      @responder = responder
      @topics_with_prefix_request = topics_with_prefix_request
      @prefixes = ('0'..'9').to_a + ('a'..'z').to_a
    end

    def send
      topics = []
      @prefixes.each do |prefix|
        response = @topics_with_prefix_request.send prefix
        topics += response.data
      end
      @responder.create_response topics
    end

  end
end