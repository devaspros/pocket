# frozen_string_literal: true

module Pocket
  class Articles
    RETRIEVE_ENDPOINT = "get"
    ARTICLE_COUNT = 10
    ARTICLE_TAG = "schedule"
    REQUEST_PARAMS = { count: ARTICLE_COUNT, tag: ARTICLE_TAG }
    MODIFY_ENDPOINT = "send"

    def initialize
      @client = Client.new(
        consumer_key: ENV['POCKET_CONSUMER_KEY'],
        access_token: ENV['ACCESS_TOKEN']
      )
    end

    def articles
      r = @client.call(endpoint: RETRIEVE_ENDPOINT, params: REQUEST_PARAMS)

      if r.status.success?
        return [] if r.body.to_s.empty?

        extract_from(JSON.parse(r.body.to_s))
      else
        puts r.body.to_s
      end
    end

    def batch_archive(ids)
      r = @client.call(endpoint: MODIFY_ENDPOINT, params: { actions: build_actions(ids) })

      if r.status.success?
        'Todo fine'
      else
        r.body.to_s
      end
    end

    private

    def extract_from(response)
      response['list'].map do |id, element|
        Article.new(element)
      end
    end

    def build_actions(ids)
      ids.map do |id|
        { "action": "archive", "item_id": id, "time": Time.now.to_i }
      end
    end

    class Article
      def initialize(article)
        @article = article
      end

      def id
        @article['item_id']
      end

      def url
        @article['resolved_url']
      end

      def title
        @article['resolved_title']
      end

      def excerpt
        @article['excerpt']
      end
    end
  end
end
