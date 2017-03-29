#GET https://www.yammer.com/api/v1/users/current.json

require_relative '../response'

module YamWow
  class CurrentUserRequest

    def initialize(client)
      @client = client
    end

    def send
      user = @client.get_other 'users/current.json'
      Response.new user
    end

  end
end