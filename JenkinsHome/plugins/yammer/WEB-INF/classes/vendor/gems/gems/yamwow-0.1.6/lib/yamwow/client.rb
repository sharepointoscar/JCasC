require 'yam'
require_relative 'throttle'

module YamWow
  class Client

    def initialize(access_token)
      @yam = Yam.new access_token, nil
      @throttles = {
          messages: Throttle.new(10, 30),
          autocomplete: Throttle.new(10, 10),
          other: Throttle.new(10, 10)
      }
    end

    def get_autocomplete(params={})
      get 'autocomplete.json', params
    end

    def get_current_user
      get 'users/current.json'
    end

    def get_messages_about_topic(topic_id, params={})
      get "messages/about_topic/#{topic_id}.json", params
    end

    def get_topic(topic_id)
      get "topics/#{topic_id}.json"
    end

    private

    def get(path, params={})
      path = '/' + path unless path.start_with? '/'
      throttle(path).when_ready do
        puts "GET #{path} #{params.inspect}"
        @yam.get path, params
      end
    end

    def throttle(path)
      case
        when path.start_with?('/messages')
          @throttles[:messages]
        when path.start_with?('/autocomplete')
          @throttles[:autocomplete]
        else
          @throttles[:other]
      end
    end

  end
end