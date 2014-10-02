desc "fetch event feed from web and save to cache"
task :fetch_events => :environment do
require 'mechanize'
require 'open-uri'
require 'memcachier'
require 'dalli'

cal = Selene.parse(open("https://www.kalkaskalibrary.org/events.ics").read)
events = []
cal['vcalendar'][0]['vevent'].each do |e|
    unless e['dtstart'][0] == ''
        event = {
        :title => e['summary'],
        :date => e['dtstart'][0].in_time_zone('Eastern Time (US & Canada)'),
        :location => e['location'],
        :body => e['description'].force_encoding("utf-8"),
        :image  => e['attach'],
        :url => e['url'],
        }
        events.push(event)
    end
end

Rails.cache.write("events", events)

end
