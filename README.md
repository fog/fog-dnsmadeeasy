# Fog::DNSMadeEasy

[![Build Status](https://travis-ci.org/fog/fog-dnsmadeeasy.svg?branch=master)](https://travis-ci.org/fog/fog-dnsmadeeasy) [![MIT Licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/fog/fog-dnsmadeeasy/master/LICENSE.md)


## API Version

This library currently uses the [DNSMadeEasy API v2](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwiLj7js_-7NAhVM_mMKHZH3BPIQFggeMAA&url=https%3A%2F%2Fwww.dnsmadeeasy.com%2Fintegration%2Fpdf%2FAPI-Docv2.pdf&usg=AFQjCNGR_Dn-U6DrXiyMJoxXJsXs8lr_sA&sig2=0ktPoLxv2_xOMBG4ebFmIA) 
and it is fully compatible with the legacy implementation bundled with the `fog` gem.

In other words, this is a drop-in replacement. Please note that the `dnsmadeeasy` provider
will eventually be removed from the `fog` gem in favor of this fog-specific module.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fog-dnsmadeeasy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fog-dnsmadeeasy


## Usage

Initialize a `Fog::DNS` object using the DNSMadeEasy provider.

```ruby
dns = Fog::DNS.new({
  provider:       "DNSMadeEasy",
  dnsmadeeasy_api_key: "YOUR_API_V2_KEY",
  dnsmadeeasy_secret_key: "YOUR_API_V2_SECRET_KEY"
})
```

This can then be used like other [Fog DNS](http://fog.io/dns/) providers.

```ruby
zone = dns.zones.create(
  domain: "example.com
)
record = zone.records.create(
  name: "example.com,
  value: "1.2.3.4,
  type: "A"
)
```

The following configurations are supported:

```ruby
dns = Fog::DNS.new({
  host:   "api.dnsmadeeasy.com",
  port:   443
  scheme: 'https'
  connection_options: {} # excon connection options

  # API V2 authentication
  dnsmadeeasy_api_key: "...",
  dnsmadeeasy_secret_key: "...",
})
```

## Contributing

1. Fork it ( https://github.com/fog/fog-dnsmadeeasy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
