require "fog/core"
require "fog/json"

module Fog
  module DNS
    class DNSMadeEasy < Fog::Service
      requires :dnsmadeeasy_api_key, :dnsmadeeasy_secret_key
      recognizes :host, :path, :port, :scheme, :persistent

      model_path 'fog/dnsmadeeasy/models/dns'
      model       :record
      collection  :records
      model       :zone
      collection  :zones

      request_path 'fog/dnsmadeeasy/requests/dns'
      request :list_domains
      request :create_domain
      request :get_domain
      request :delete_domain
      request :create_record
      request :list_records
      request :update_record
      request :delete_record
      request :get_record

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
                :domains => [],
                :records => {}
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options={})
          @dnsmadeeasy_api_key = options[:dnsmadeeasy_api_key]
          @dnsmadeeasy_secret_key = options[:dnsmadeeasy_secret_key]
        end

        def data
          self.class.data[@dnsmadeeasy_api_key]
        end

        def reset_data
          self.class.data.delete(@dnsmadeeasy_api_key)
        end
      end

      class Real
        def initialize(options={})
          @dnsmadeeasy_api_key = options[:dnsmadeeasy_api_key]
          @dnsmadeeasy_secret_key = options[:dnsmadeeasy_secret_key]
          @connection_options = options[:connection_options] || {}
          @host       = options[:host]        || 'api.dnsmadeeasy.com'
          @persistent = options.fetch(:persistent, true)
          @port       = options[:port]        || 443
          @scheme     = options[:scheme]      || 'https'
          @connection = Fog::XML::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
        end

        def reload
          @connection.reset
        end

        def request(params)
          params[:headers] ||= {}
          params[:headers]['x-dnsme-apiKey'] = @dnsmadeeasy_api_key
          params[:headers]['x-dnsme-requestDate'] = Fog::Time.now.to_date_header
          params[:headers]['x-dnsme-hmac'] = signature(params)
          params[:headers]['Accept'] = 'application/json'
          params[:headers]['Content-Type'] = 'application/json'

          begin
            response = @connection.request(params)

          rescue Excon::Errors::HTTPStatusError => error
            raise case error
            when Excon::Errors::NotFound
              Fog::DNS::DNSMadeEasy::NotFound.slurp(error)
            else
              error
            end
          end

          unless response.body.empty?
            response.body = Fog::JSON.decode(response.body)
          end

          response
        end

        def signature(params)
          string_to_sign = params[:headers]['x-dnsme-requestDate']
          OpenSSL::HMAC.hexdigest('sha1', @dnsmadeeasy_secret_key, string_to_sign)
        end
      end
    end
  end
end
