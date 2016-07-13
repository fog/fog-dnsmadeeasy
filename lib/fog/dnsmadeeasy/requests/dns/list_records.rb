module Fog
  module DNS
    class DNSMadeEasy
      class Real
        # Get the list of records for the specific domain.
        #
        # ==== Parameters
        # * domain<~String> - domain numeric ID
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * <~Array>:
        #       * 'record'<~Hash> The representation of the record.
        def list_records(domain)
          request(
            :expects  => 200,
            :method   => "GET",
            :path     => "/V2.0/dns/managed/#{domain}/records"
          )
        end
      end

      class Mock
        def list_records(domain)
          response = Excon::Response.new
          response.status = 200
          response.body = self.data[domain] || []
          response
        end
      end
    end
  end
end
