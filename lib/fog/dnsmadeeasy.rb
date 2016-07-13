require "fog/core"
require_relative "dnsmadeeasy/version"

module Fog
  module DNSMadeEasy
    extend Fog::Provider

    service(:dns, 'DNS')
  end

  module DNS
    autoload :DNSMadeEasy, File.expand_path('../dnsmadeeasy/dns', __FILE__)
  end
end
