module Fog
  module DNS
    class DNSMadeEasy
      class Real
        # Delete the record with the given ID for the given domain.
        #
        # ==== Parameters
        # * domain<~String> - domain name or numeric ID
        # * record_id<~String>
        def delete_record(domain, record_id)
          request(
            :expects  => 200,
            :method   => "DELETE",
            :path     => "/V2.0/dns/managed/#{domain}/records/#{record_id}"
          )
        end
      end

      class Mock
        def delete_record(domain, record_id)
          self.data[domain].reject! { |record| record["id"] == record_id }

          response = Excon::Response.new
          response.status = 200
          response
        end
      end
    end
  end
end
