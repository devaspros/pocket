require 'sinatra'

require_relative 'lib/pocket'

enable :sessions

CALLBACK_URL = "http://localhost:4567/oauth/callback"

get "/" do
  puts "session: #{session}"

  if session[:access_token] || !ENV['ACCESS_TOKEN'].empty?
    puts Pocket::Articles.new.articles
    "
      <h2>Pocket Token</h2>
      <p>#{session[:access_token]}</p>
    "
  else
    '<a href="oauth/connect">Connect with Pocket</a>'
  end
end

get "/oauth/connect" do
  puts "OAUTH CONNECT"

  connect_client = Pocket::Oauth::Connect.new

  # get the `code` that's converted to a `pocket_token`
  # make call to /v3/oauth/request
  code = connect_client.connect
  session[:code] = code
  puts code

  # and redirect to the pocket website with query parameters to authorize the code
  # https://getpocket.com/auth/authorize?request_token=YOUR_REQUEST_TOKEN&redirect_uri=YOUR_REDIRECT_URI
  auth_url = connect_client.authorize(code)

  redirect(auth_url)
end

get "/oauth/callback" do
  puts "OAUTH CALLBACK"

  # convert the code to a pocket_token
  # make call to /v3/oauth/authorize
  pocket_token = Pocket::Oauth::Connect.new.pocket_token(session[:code])
  session[:access_token] = pocket_token
  puts pocket_token

  redirect "/"
end
