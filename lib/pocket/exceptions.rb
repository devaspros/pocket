# lib/pocket/exceptions.rb

module Pocket
  class MissingPocketConsumerKeyError < StandardError
    def initialize(msg = 'ENV var POCKET_CONSUMER_KEY not configured')
      super
    end
  end

  class MissingCallbackUrlError < StandardError
    def initialize(msg = 'ENV var CALLBACK_URL not configured')
      super
    end
  end
end
