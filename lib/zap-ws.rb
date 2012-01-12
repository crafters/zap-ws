#encoding: utf-8
require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash'
require 'savon'

require 'zap-ws/message'
require 'zap-ws/web_service'

module ZapWs
  @@client_id = ""
  mattr_accessor :client_id
  @@client_password = ""
  mattr_accessor :client_password
  
  def self.setup
    yield self
  end
  
  class InvalidClientCode < Exception; end
  class InvalidClientPassword < Exception; end
end