desc "fetch news feed from web and save to cache"
task :fetch_news => :environment do
require 'mechanize'
require 'open-uri'
require 'memcachier'
require 'dalli'

news = JSON.parse(open("https://www.kalkaskalibrary.org/wp-json/posts").read)

Rails.cache.write("news", news)

end
