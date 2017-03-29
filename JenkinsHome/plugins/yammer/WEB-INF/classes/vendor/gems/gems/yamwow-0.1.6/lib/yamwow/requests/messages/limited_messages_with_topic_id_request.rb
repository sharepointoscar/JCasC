module YamWow
  class LimitedMessagesWithTopicIdRequest

    def initialize(client, responder)
      @client = client
      @responder = responder
    end

    def send(topic_id, options={})
      data = @client.get_messages_about_topic topic_id, threaded: true, older_than: options[:older_than_id]
      @responder.create_response data['messages'], data['references']
    end

  end
end