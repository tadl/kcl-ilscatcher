desc "fetch event feed from web and save to cache"
task :fetch_events => :environment do
require 'mechanize'
require 'open-uri'
require 'memcachier'
require 'dalli'

#events = JSON.parse(open("https://www.tadl.org/mobile/export/events/formatted/json/all").read)['nodes'].map {|i| i['node']}

events = Selene.parse(open("https://www.kalkaskalibrary.org/events.ics").read)
#puts events

Rails.cache.write("events", events)

end
