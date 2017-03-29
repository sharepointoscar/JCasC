ENV['SSL_CERT_FILE'] ||= File.expand_path(File.dirname(__FILE__) + '/cacert.pem')
require_relative 'yamwow/facade'