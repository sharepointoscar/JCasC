require_relative '../../response'

module YamWow
  class CurrentUserRequest

    def initialize(client)
      @client = client
    end

    def send
      data = @client.get_current_user
      Response.new data
    end

  end
end