require 'rubygems'
require 'oauth'
require 'json'
require "open-uri"
require 'JSON'
require './keys'

#read a timeline

# Now you will fetch /1.1/statuses/user_timeline.json,
# returns a list of public Tweets from the specified
# account.
baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/user_timeline.json"
query   = URI.encode_www_form(
    "screen_name" => "buildsucceeded",
    "count" => 5,
)
address = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri

# Print data about a list of Tweets
def print_timeline(tweets)
  
    puts tweets [0]["user"]["screen_name"]
    puts tweets [0]["text"]
end

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Set up OAuth
consumer_key = OAuth::Consumer.new($twitter_api_key, $twitter_api_secret)
access_token = OAuth::Token.new($twitter_access_token, $twitter_access_secret)

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweets = nil
if response.code == '200' then
  tweets = JSON.parse(response.body)
  print_timeline(tweets)
  else
  puts response.code
  puts JSON.parse(response.body)

#check to see if a certain word is in the tweets
words = ["sad","moody","depressed"]

for tweet in tweets
	for word in words

		if tweet[word]
			statement = true
		else statement = false


#do image search of that word
queryString = ARGV[0]

if statement == true
	queryString = 'puppy'

query_url = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{queryString}"
puts query_url
puts queryString

json = JSON.parse(open(query_url).read)

url = json["responseData"]["results"][0]["url"]

puts url

#post a tweet with image

# You will need to set your application type to
# read/write on dev.twitter.com and regenerate your access
# token.  Enter the new values here:
consumer_key = 
  "jPtNR4XZQisNZKnM3lqpaS483",
  "6mnbF0qfz715Sb4bQCmL2D2FRZLKF2lgLoNZ1OqoOZzOq8q0tC"
access_token =
  "3062007137-gLDJ7SaDruF76IQ8SKMQdcZo55zYNEpXYhhtufN",
  "6hVpBowHSwuoNcK89aJhAIvfhjhRtiwjm0r41yRW4qgvy"

# Note that the type of request has changed to POST.
# The request parameters have also moved to the body
# of the request instead of being put in the URL.
baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/update.json"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post.new address.request_uri
request.set_form_data(
  "status" => "Sorry you're feeling sad, here's a puppy! #{url}",
)

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweet = nil
if response.code == '200' then
  tweet = JSON.parse(response.body)
  puts "Successfully sent #{tweet["text"]}"
else
  puts "Could not send the Tweet! " +
  "Code:#{response.code} Body:#{response.body}"
end
