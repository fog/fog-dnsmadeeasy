module Fog
  module DNS
    class DNSMadeEasy
      class Real
        # Get the details for a specific domain in your account. You
        # may pass either the domain numeric ID or the domain name itself.
        #
        # ==== Parameters
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * <~Array>:
        #       * 'domain'<~Hash> The representation of the domain.
        def list_domains
          request(
            :expects  => 200,
            :method   => 'GET',
            :path     => '/V2.0/dns/managed'
          )
        end
      end

      class Mock
        def list_domains
          response = Excon::Response.new
          response.status = 200
          response.body = self.data
          response
        end
      end
    end
  end
end
