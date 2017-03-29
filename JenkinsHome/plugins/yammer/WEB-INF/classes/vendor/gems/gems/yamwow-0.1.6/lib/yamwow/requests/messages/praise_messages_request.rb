module YamWow
  class PraiseMessagesRequest

    def initialize(responder, messages_with_topic_name_request)
      @responder = responder
      @messages_with_topic_name_request = messages_with_topic_name_request
    end

    def send
      r = @messages_with_topic_name_request.send 'praise'
      @responder.create_response r.data, r.reference_data
    end

  end
end