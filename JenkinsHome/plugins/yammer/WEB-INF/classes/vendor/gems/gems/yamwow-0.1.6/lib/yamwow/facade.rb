require_relative 'client'
require_relative 'requests'
require_relative 'topics_responder'
require_relative 'messages_responder'
require_relative 'praise_messages_responder'

module YamWow
  class Facade

    def initialize(access_token)
      client = Client.new access_token
      topics_responder = TopicsResponder.new
      messages_responder = MessagesResponder.new
      praise_messages_responder = PraiseMessagesResponder.new messages_responder

      @group_with_name_request = GroupWithNameRequest.new client

      limited_topics_with_prefix_request = LimitedTopicsWithPrefixRequest.new client, topics_responder
      @topics_with_prefix_request = TopicsWithPrefixRequest.new topics_responder, limited_topics_with_prefix_request
      @topic_with_name_request = TopicWithNameRequest.new @topics_with_prefix_request
      @topics_request = TopicsRequest.new topics_responder, @topics_with_prefix_request

      limited_messages_with_topic_id_request = LimitedMessagesWithTopicIdRequest.new client, messages_responder
      @messages_with_topic_id_request = MessagesWithTopicIdRequest.new messages_responder, limited_messages_with_topic_id_request
      @messages_with_topic_name_request = MessagesWithTopicNameRequest.new @topic_with_name_request, @messages_with_topic_id_request
      @praise_messages_request = PraiseMessagesRequest.new praise_messages_responder, @messages_with_topic_name_request

      @current_user_request = CurrentUserRequest.new client
    end

    def group_with_name(group_name)
      @group_with_name_request.send group_name
    end

    def messages_with_topic_id(topic_id)
      @messages_with_topic_id_request.send(topic_id)
    end

    def messages_with_topic_name(topic_name)
      @messages_with_topic_name_request.send topic_name
    end

    def praise_messages
      @praise_messages_request.send
    end

    def topic_with_name(topic_name)
      @topic_with_name_request.send topic_name
    end

    def topics
      @topics_request.send
    end

    def topics_with_prefix(topic_prefix)
      @topics_with_prefix_request.send topic_prefix
    end

    def current_user
      @current_user_request.send
    end

  end
end