# frozen_string_literal: true

require "dotenv/load"
require "byebug"
require "http"

require_relative "pocket/version"
require_relative "pocket/exceptions"
require_relative "pocket/articles"
require_relative "pocket/oauth/connect"

Dotenv.load('.env', '.env.local', '.env.test')

module Pocket
  class Client
    BASE_URL = "https://getpocket.com/v3"
    HEADERS = { "Content-Type" => "application/json" }

    def call(endpoint:, params:)
      HTTP.headers(HEADERS)
          .post("#{BASE_URL}/#{endpoint}", json: params)
    end
  end
end
