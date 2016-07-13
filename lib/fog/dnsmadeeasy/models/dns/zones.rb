require 'fog/core/collection'
require 'fog/dnsmadeeasy/models/dns/zone'

module Fog
  module DNS
    class DNSMadeEasy
      class Zones < Fog::Collection
        model Fog::DNS::DNSMadeEasy::Zone

        def all
          clear
          data = service.list_domains.body['data'].map{|domain|
                                                         {:id => domain['id'],
                                                          :domain => domain['name'],
                                                          :gtd_enabled => domain['gtdEnabled'],
                                                          :nameservers => nil}}
          load(data)
        end

        def get(zone_id)
          data = service.get_domain(zone_id).body
          data.merge!(:id => data['name'])
          new(data)
        rescue Fog::Service::NotFound
          nil
        end

        def get_id(name)
	  data = service.list_domains.body['data'].select{|domain| domain['name'] == name}[0]['id']
	  new(data)
        rescue Fog::Service::NotFound
          nil
        end

      end
    end
  end
end
