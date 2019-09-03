require 'rubygems'
require 'sinatra'
require 'httparty'

get '/' do
  # settings
  @app_url         = 'http://localhost:30990' # Your callback URL configured - Fetch from App page 
  @client_id       = '566f6e95678' # Copy client id from App Manager - Fetch from App page
  @client_secret   = '6717c9b71d6776e3083e35eeda7d38' # Copy client secret from App Manager - Fetch from App page
  @fidor_oauth_url = 'http://appmanager.com/oauth' # Copy oauth url from App Manager - Fetch from App page
  @fidor_api_url   = 'http://apigateway.com/' # Copy API url from API Doc

  # 1. redirect to authorize url
  unless code = params["code"]
    dialog_url = "#{@fidor_oauth_url}/authorize?client_id=#{@client_id}&redirect_uri=#{CGI::escape(@app_url)}&state=approved&response_type=code"
    redirect dialog_url
  end

  # 2. get the access token, with code returned from auth dialog above
  token_url = URI("#{@fidor_oauth_url}/token")
  post_params = { client_id: @client_id,
                  redirect_uri: CGI::escape(@app_url),
                  code: code,
                  grant_type: 'authorization_code' }
  auth = {:username => @client_id, :password => @client_secret}
  resp = HTTParty.post(token_url, body: post_params, basic_auth: auth )

  # GET current user setting the access-token in the request header
  user = HTTParty.get( "#{@fidor_api_url}/users/current",
                       headers: { 'Authorization' => "Bearer #{resp['access_token']}",
                                  'Accept'        => "application/vnd.fidor.de; version=1,text/json"} )

  "<h2>Hello #{user['email']}</h2>
   <i>Access token presented below :</i>
   <pre><code>#{resp.body}</code></pre>
   <p>Now use the access token in the header of your requests, e.g. using CURL</p>
   <h3>GET /accounts</h3>
   <pre><code>
   curl -v --header \"Accept: application/vnd.fidor.de; version=1,text/json\" --header \"Authorization: Bearer #{resp['access_token']}\" #{@fidor_api_url}/accounts
   </code></pre>
   <h3>GET /transactions</h3>
   <pre><code>
   curl -v --header \"Accept: application/vnd.fidor.de; version=1,text/json\" --header \"Authorization: Bearer #{resp['access_token']}\" #{@fidor_api_url}/transactions?per_page=5
   </code></pre>"
end
