# encoding: utf-8
require 'uri'
require 'digest/sha1'
require 'net/http'

module Bitrunner
  class Client
    attr_reader :api_key, :api_secret

    ENDPOINT = "http://api.bitsontherun.com/"
    FORMAT   = "json"
    VERSION  = "v1"

    def initialize(options)
      @api_key = options[:api_key]
      @api_secret = options[:api_secret]
    end

    def get(path, parameters)
      Net::HTTP.get(url(path, parameters))
    end
        
    def url(path, parameters)
      URI.parse(base_url(path) + "?#{signed_query_string(parameters)}")
    end
    
    def base_url(path)
      File.join(ENDPOINT, VERSION, path)
    end

    def signature(string)
      Digest::SHA1.hexdigest(string + api_secret)
    end
    
    def query_string(parameters)
      default_parameters.merge(parameters).
        map { |key, value| [URI.encode(key.to_s), URI.encode(value.to_s)]}.
        sort { |a,b| a.first <=> b.first }.
        map { |e| e.join('=') }.join('&')
    end
    
    def signed_query_string(parameters)
      q = query_string(parameters)
      "#{q}&api_signature=#{signature(q)}"
    end

    def default_parameters
      {
        api_format: FORMAT,
        api_key: api_key,
        api_nonce: nonce,
        api_timestamp: timestamp
      }
    end
    
    def nonce
      (0..8).map { rand(10) }.join
    end
    
    def timestamp
      Time.now.to_i
    end
  end
end