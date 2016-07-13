module Fog
  module DNS
    class DNSMadeEasy
      class Real
        # Create a new host in the specified zone
        #
        # ==== Parameters
        # * domain<~String> - domain numeric ID
        # * name<~String>
        # * type<~String>
        # * content<~String>
        # * options<~Hash> - optional
        #   * priority<~Integer>
        #   * ttl<~Integer>
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'record'<~Hash> The representation of the record.
        def create_record(domain, name, type, content, options = {})
          body = {
            "name" => name,
            "type" => type,
            "value" => content,
	    "ttl" => 1800
          }

          body.merge!(options)

          request(
            :body     => Fog::JSON.encode(body),
            :expects  => 201,
            :method   => 'POST',
            :path     => "/V2.0/dns/managed/#{domain}/records"
          )
        end
      end

      class Mock
        def create_record(domain, name, type, content, options = {})
          body = {
            "id" => Fog::Mock.random_numbers(1).to_i,
            "domain_id" => domain,
            "name" => name,
            "value" => content,
            "ttl" => 1800,
            "priority" => nil,
            "type" => type,
          }.merge(options)
          self.data[domain] ||= []
          self.data[domain] << body

          response = Excon::Response.new
          response.status = 201
          response.body = body
          response
        end
      end
    end
  end
end
