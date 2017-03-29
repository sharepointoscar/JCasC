require_relative '../response'

module YamWow
  class TopicWithIdRequest

    def initialize(client, topic_id)
      @client = client
      @topic_id = topic_id
    end

    def send
      topic = @client.get_other "topics/#{@topic_id}.json"
      Response.new topic
    end

  end
end