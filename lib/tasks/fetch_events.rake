desc "fetch event feed from web and save to cache"
task :fetch_events => :environment do
require 'mechanize'
require 'open-uri'
require 'memcachier'
require 'dalli'

events = []

cal = Hash.from_xml(open("https://www.kalkaskalibrary.org/events/feed/").read)

cal['rss']['channel']['item'].each do |e|
    event = {
        :title => e['title'],
        :date => e['startDate'],
        :image => e['postImage'],
        :url => e['link'],
        :uid => e['postId'],
        :body => e['description'].force_encoding("utf-8"),
    }
    events.push(event)
end

Rails.cache.write("events", events)

end
