require_relative 'client'
require_relative 'requests'

module YamWow
  class Facade

    def initialize(oauth_token)
      @client = Client.new oauth_token
    end

    def messages_with_topic(topic_name, options={})
      MessagesWithTopicRequest.new(@client, topic_name, options).send
    end

    def praises(options={})
      PraiseRequest.new(@client, options).send
    end

    def topic_with_name(topic_name, options={})
      TopicWithNameRequest.new(@client, topic_name, options).send
    end

    def topics(options={})
      TopicsRequest.new(@client, options).send
    end

    def group_with_name(group_name)
      GroupWithNameRequest.new(@client, group_name).send
    end

    def current_user
      CurrentUserRequest.new(@client).send
    end

  end
end