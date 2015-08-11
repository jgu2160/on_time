require 'hurley'
require 'json'

class TravelTime
  SERVER_API_KEY= File.readlines("api_key.txt")[0]

  def initialize(origin="turing school denver", destination="colorado state capitol", mode="driving")
    origin = origin.gsub(" ", "+")
    destination = destination.gsub(" ", "+")
    mode = mode
    @response = Hurley.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&units=imperial&mode=#{mode}&key=#{SERVER_API_KEY}")
  end

  def body
    body = JSON.parse(@response.body)
    puts body["rows"][0]["elements"][0]["duration"]["text"]
    body["rows"][0]["elements"][0]["duration"]["value"]
  end
end

if __FILE__ == $0
  tt = TravelTime.new
  tt.body
end
