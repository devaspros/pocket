require 'dotenv/load'
require "pocket/version"

module Pocket
  class Error < StandardError; end

  class Client
  	def hola
      puts ENV['POCKET_CONSUMER_KEY']
  	end
  end
end
