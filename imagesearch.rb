#do image search of that word

def image_search(queryString)

#queryString = ARGV[0]

if statement == true
	queryString = 'puppy'

query_url = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{queryString}"
json = JSON.parse(open(query_url).read)

url = json["responseData"]["results"][0]["url"]

puts url

url

end