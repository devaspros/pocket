# frozen_string_literal: true
# lib/oauth/connect.rb

module Pocket
  module Oauth
    CONNECT_ENDPOINT = 'oauth/request'
    CONNECT_PARAMS = {
      consumer_key: ENV['POCKET_CONSUMER_KEY'],
      redirect_uri: ENV['CALLBACK_URL']
    }

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

      def authorize; end
    end
  end
end
