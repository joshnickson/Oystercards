require "./lib/oystercard"
require "./lib/station"

card = Oystercard.new
card.top_up(500)
card.touch_in(Station.new)
card.touch_out(Station.new)
p card.journeys
# p card.in_journey?
