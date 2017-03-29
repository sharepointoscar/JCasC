require 'yam'
require_relative 'throttle'

module YamWow
  class Client

    def initialize(oauth_token)
      @yam = Yam.new oauth_token, nil
      @message_throttle = Throttle.new 10, 30
      @autocomplete_throttle = Throttle.new 10, 10
      @other_throttle = Throttle.new 10, 10
    end

    def get_messages(path=nil, params={})
      path = path ? File.join('messages', path) : 'messages.json'
      get path, params, @message_throttle
    end

    def get_autocomplete(params={})
      get 'autocomplete.json', params, @autocomplete_throttle
    end

    def get_other(path, params={})
      get path, params, @other_throttle
    end

    private

    def get(path, params, throttle)
      path = '/' + path unless path.start_with? '/'
      throttle.when_ready do
        puts "GET #{path} #{params.inspect}"
        @yam.get path, params
      end
    end

  end
end