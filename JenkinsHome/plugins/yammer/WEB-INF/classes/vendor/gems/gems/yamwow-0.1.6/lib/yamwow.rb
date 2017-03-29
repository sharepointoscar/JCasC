ENV['SSL_CERT_FILE'] ||= File.expand_path(File.dirname(__FILE__) + '/cacert.pem')
require_relative 'yamwow/facade'

module YamWow
  class << self
    def new(access_token)
      Facade.new access_token
    end
  end
end