# frozen_string_literal: true

require "dotenv/load"
require "amazing_print"
require "byebug"
require "http"

require "pocket/version"
require "pocket/articles"

module Pocket
  class Error < StandardError; end

  class Client
    BASE_URL = "https://getpocket.com/v3"
    HEADERS = { "Content-Type" => "application/json" }

    def initialize(consumer_key:, access_token:)
      @consumer_key = consumer_key
      @access_token = access_token
      @options = { consumer_key: consumer_key, access_token: access_token }
    end

    def retrieve(endpoint:, params:)
      HTTP.headers(HEADERS)
          .post("#{BASE_URL}/#{endpoint}", json: params.merge(@options))
    end
  end
end
