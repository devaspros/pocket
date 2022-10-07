# frozen_string_literal: true

module Pocket
  class Articles
    RETRIEVE_ENDPOINT = "get"
    MODIFY_ENDPOINT = "send"

    def initialize(args = {})
      @client = Client.new
      @request_payload = {
        access_token: args.fetch(:access_token, nil),
        count: 10,
        tag: "schedule",
        consumer_key: ENV.fetch('POCKET_CONSUMER_KEY')
      }
    end

    def articles
      r = @client.call(endpoint: RETRIEVE_ENDPOINT, params: @request_payload)

      if r.status.success?
        return [] if r.body.to_s.empty?

        extract_from(JSON.parse(r.body.to_s))
      else
        puts r.body.to_s
      end
    end

    def batch_archive(ids)
      actions = { actions: build_actions(ids) }

      r = @client.call(endpoint: MODIFY_ENDPOINT, params: @request_payload.merge(actions))

      if r.status.success?
        puts "Articles archived succesfully"
        true
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
