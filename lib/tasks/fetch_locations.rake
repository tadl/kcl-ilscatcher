desc "fetch location feeds from web and save to cache"
task :fetch_locations => :environment do
require 'mechanize'
require 'open-uri'
require 'memcachier'
require 'dalli'

main = JSON.parse(open("https://spreadsheets.google.com/feeds/list/14X5XDcKOEopBEuVwbrGs8ZLJn4ICfsCjtXpAInnk6Rw/od6/public/values?alt=json").read)

Rails.cache.write("locations", main)

end
