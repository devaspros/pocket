# frozen_string_literal: true

module Pocket
  class Articles
    RETRIEVE_ENDPOINT = "get"
    ARTICLE_COUNT = 10
    ARTICLE_TAG = "schedule"

    REQUEST_PARAMS = { count: ARTICLE_COUNT, tag: ARTICLE_TAG }

    def initialize
      @client = Client.new(
        consumer_key: ENV['POCKET_CONSUMER_KEY'],
        access_token: ENV['ACCESS_TOKEN']
      )
    end

    def articles
      r = @client.retrieve(endpoint: RETRIEVE_ENDPOINT, params: REQUEST_PARAMS)

      if r.status.success?
        JSON.parse(r.body.to_s)
      else
        puts r.body.to_s
      end
    end
  end
end
