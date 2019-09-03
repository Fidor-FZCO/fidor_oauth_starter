# Ruby oAuth - Example

A single view that demonstrates the Fidor API OAuth login flow and how to get 
an access token. Uses Sinatra on its server side.

## Pre Requisities

Choose a port that you will be running this application. After that, go to App Manager, create an app and mention the callback url as this App's root URL. 

## Usage

This uses bundler to install the required gems:

  cd ruby_oauth_plain
  bundle install
  
## Run on the port mentioned while creating the app in App Manager
  ruby example.rb -p 30990

## Configuration

You'll need to open the
`example.rb` file and fill in the configuration values at the top of the
file. You will be able to find out the values in the AppManager when you create
a new application. The values will be displayed in the app details page.
You can get app_url, client_id, client_secret, fidor_oauth_url from App Details page.
fidor_api_url has to be fetched from the API Doc.