require "dotenv/load"
require "amazing_print"
require "http"

require "pocket/version"

module Pocket
  class Error < StandardError; end

  class Client
  	def test_env
      puts ENV['POCKET_CONSUMER_KEY']
  	end

    def test_request
      puts HTTP.get("https://github.com").body
    end
  end
end
