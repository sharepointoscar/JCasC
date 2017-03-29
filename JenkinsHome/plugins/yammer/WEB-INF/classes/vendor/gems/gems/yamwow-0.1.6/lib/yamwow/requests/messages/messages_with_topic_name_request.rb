module YamWow
  class MessagesWithTopicNameRequest

    def initialize(topic_with_name_request, messages_with_topic_id_request)
      @messages_with_topic_id_request = messages_with_topic_id_request
      @topic_with_name_request = topic_with_name_request
    end

    def send(topic_name)
      @topic_name = topic_name
      @messages_with_topic_id_request.send topic_id
    end

    private

    def topic_id
      response = @topic_with_name_request.send @topic_name
      response.data['id'] if response.data
    end

  end
end