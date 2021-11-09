# frozen_string_literal: true
# lib/oauth/connect.rb

module Pocket
  module Oauth
    CONNECT_ENDPOINT = 'oauth/request'
    CONNECT_PARAMS = {
      consumer_key: ENV['POCKET_CONSUMER_KEY'],
      redirect_uri: ENV['CALLBACK_URL']
    }
    AUTHORIZE_URL = 'https://getpocket.com/auth/authorize'
    AUTHORIZE_ENDPOINT = 'oauth/authorize'

    # Connect to Pocket /v3/oauth/request to obtain a response token or code.
    class Connect
      def initialize
        @client = Client.new
      end

      def connect
        r = @client.call(endpoint: CONNECT_ENDPOINT, params: CONNECT_PARAMS)

        if r.status.success?
          parsed = Hash[URI.decode_www_form(r.body.to_s)]
          parsed['code']
        else
          puts r.body.to_s
        end
      end

      # Generates this auth URL
      # https://getpocket.com/auth/authorize?request_token=YOUR_REQUEST_TOKEN&redirect_uri=YOUR_REDIRECT_URI
      def authorize(code)
        "#{AUTHORIZE_URL}?request_token=#{code}&redirect_uri=#{ENV['CALLBACK_URL']}"
      end

      # Turn the initial response `code` into a usable `pocket_token`
      # to make requests to Pocket API.
      def pocket_token(code)
        r = @client.call(endpoint: AUTHORIZE_ENDPOINT, params: authorize_params(code))

        if r.status.success?
          parsed = Hash[URI.decode_www_form(r.body.to_s)]
          parsed['access_token']
        else
          puts r.body.to_s
        end
      end

      private

      def authorize_params(code)
        CONNECT_PARAMS.merge(code: code)
      end
    end
  end
end
