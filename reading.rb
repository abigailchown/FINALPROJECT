#reading a tweet
require 'rubygems'
require 'oauth'
require 'json'

def twitter_search(queryString)

baseurl = "https://api.twitter.com"
path    = "/1.1/search/tweets.json?q="
address = URI("#{baseurl}#{path}#{queryString}")
request = Net::HTTP::Get.new address.request_uri

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
request.oauth! http, $consumer_key, $access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweet = nil
if response.code == '200' then
  json = JSON.parse(response.body)
  
  tweets = json["statuses"]
  # Printing commented out; delete '#' to debug:
  # printSearchResults(tweets)
  puts tweets
  else
  puts response.code
  puts JSON.parse(response.body)
end

#return the tweets to the calling script
tweets
end
