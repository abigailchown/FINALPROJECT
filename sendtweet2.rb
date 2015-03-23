require 'rubygems'
require 'oauth'
require 'json'

def post_tweet(username, noun, imgURL)


    # Note that the type of request has changed to POST.
    # The request parameters have also moved to the body
    # of the request instead of being put in the URL.
    baseurl = "https://api.twitter.com"
    path    = "/1.1/statuses/update.json"
    address = URI("#{baseurl}#{path}")
    request = Net::HTTP::Post.new address.request_uri
    request.set_form_data(
      "status" => "Hey @#{username}! Sorry you're feeling sad, to make you feel better here's a puppy! #{imgURL} ",

    )

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, $oauth_consumer, $oauth_access
    http.start
    response = http.request request

    #Dont understand this part 
    # Parse and print the Tweet if the response code was 200
    tweet = nil
    if response.code == '200' then
      tweet = JSON.parse(response.body)
      puts "Successfully sent #{tweet["text"]}"
    else
      puts "Could not send the Tweet! " +
      "Code:#{response.code} Body:#{response.body}"
    end

end