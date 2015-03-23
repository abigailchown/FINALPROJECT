require './keys'

require 'rubygems'
require 'oauth'
require 'json'
require "open-uri"
require 'JSON'
require './imagesearch'
require './reading'
require './sendtweet2'

# Set up OAuth
$oauth_consumer = OAuth::Consumer.new($consumer_key, $consumer_secret)
$oauth_access = OAuth::Token.new($access_token, $access_secret)

#check to see if a certain word is in the tweets
queryString = ARGV[0]

if !queryString then
    queryString = 'sad'
end

puts 'running with query: ' + queryString

tweets = twitter_search(queryString)

#return early if we don't have any tweets
if !tweets then
    puts 'No tweets loaded!'
    return
end

url = image_search(queryString)

if !url then
    puts 'No url found!'
    return
end

#iterate through all the tweets and respond to them
for tweet in tweets
    tweet = tweets[0]
    
    username = tweet["user"]["screen_name"]
    puts 'tweeting at --> @' + username
    
    success = post_tweet(username, queryString, url)
    
    puts 'tweet post result: ' + success
end


puts "Successfully sent #{tweet["text"]}"


