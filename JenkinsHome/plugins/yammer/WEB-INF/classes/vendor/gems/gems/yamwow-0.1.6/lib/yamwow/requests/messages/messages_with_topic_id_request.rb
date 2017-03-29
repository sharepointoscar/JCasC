module YamWow
  class MessagesWithTopicIdRequest

    def initialize(responder, limited_messages_with_topic_id_request)
      @responder = responder
      @limited_messages_with_topic_id_request = limited_messages_with_topic_id_request
    end

    def send(topic_id)
      @topic_id = topic_id
      @messages = []
      @references = []
      add_messages
      @responder.create_response @messages, @references
    end

    private

    def add_messages
      response = @limited_messages_with_topic_id_request.send(@topic_id, older_than_id: oldest_message_id)
      @messages += response.data
      @references += response.reference_data
      add_messages unless response.data.empty?
    end

    private

    def oldest_message_id
      @messages.empty? ? nil : @messages.last['id']
    end

  end
end