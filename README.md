# Ruby oauth - Example

A single app that demonstrates the API OAuth login flow and how to get 
an access token. Uses Sinatra on its server side.

## Pre Requisities

Choose a port that you will be running this application. After that, go to App Manager, create an app and mention the callback url as this App's root URL. 

## Usage

This uses bundler to install the required gems:

```sh
cd fidor_oauth_starter
bundle install
```
  
## Run on the port (port_number) mentioned while creating the app in App Manager
  ruby example.rb -p port_number

## Configuration

You'll need to open the
`example.rb` file and fill in the configuration values at the top of the
file. You will be able to find out the values in the AppManager when you create
a new application. The values will be displayed in the app details page.
You can get app_url, client_id, client_secret, fidor_oauth_url from App Details page.
fidor_api_url has to be fetched from the API Doc.