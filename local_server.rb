require 'sinatra'

require_relative 'lib/pocket'

enable :sessions

CALLBACK_URL = "http://localhost:4567/oauth/callback"

get "/" do
  puts "session: #{session}"

  if session[:access_token] || !ENV['ACCESS_TOKEN'].empty?
    puts Pocket::Articles.new.articles
  else
    '<a href="oauth/connect">Connect with Pocket</a>'
  end
end

get "/oauth/connect" do
  puts "OAUTH CONNECT"

  # get the `code` that's converted to a `pocket_token`
  # make call to /v3/oauth/request
  code = Pocket::Oauth::Connect.new.connect
  puts code

  # and redirect to the pocket website with query parameters to authorize the code
  # https://getpocket.com/auth/authorize?request_token=YOUR_REQUEST_TOKEN&redirect_uri=YOUR_REDIRECT_URI
  'dale'
end

get "/oauth/callback" do
  puts "OAUTH CALLBACK"

  # convert the code to a pocket_token
  # make call to /v3/oauth/authorize
end
