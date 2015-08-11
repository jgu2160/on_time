require_relative "travel_time"
require_relative "calendar"
cal = CalEvents.new
events = cal.events

events_with_location = events.select do |event|
  event[:location]
end

soonest = events_with_location.first

tt = TravelTime.new(soonest[:location])
time = tt.body

delta = soonest[:start] - time - Time.now

minutes = (delta / 60) % 60
hours = delta / (60 * 60)
if hours < 1
  formatted = format("%02d minutes", minutes)
else
  formatted = format("%02d hours and %02d minutes", hours, minutes)
end

puts "You should probably leave within #{formatted} in order to get to #{soonest[:location]} on time."

