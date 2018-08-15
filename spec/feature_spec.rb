require "oystercard"
require "station"
require "journeys"

describe "Oystercard feature tests" do
  it "as a customer I want money on my card" do
    given_a_user_has_a_new_card
    card_should_show_us_the_balance
  end

  it "allows a user to top up a card" do
    given_a_user_has_a_new_card
    card_can_be_topped_up_and_return_new_balance
  end

  it "enforces a maximum limit on my oystercard" do
    given_a_user_has_a_new_card
    card_enforces_maximum_balance
  end

  # it "deducts fare from card balance" do
  #   given_a_user_has_a_new_card
  #   the_card_has_been_topped_up
  #   a_fare_can_be_deducted_from_balance
  # end

  it "records when card has been touched in" do
    given_a_user_has_a_new_card
    is_in_a_station_ready_to_go
    the_card_has_been_topped_up
    card_has_been_touched_in
    card_will_show_as_in_use
  end

  it "remembers the touch in station during the journey" do
    given_a_user_has_a_new_card
    is_in_a_station_ready_to_go
    the_card_has_been_topped_up
    card_has_been_touched_in
    card_will_know_the_touch_in_station
  end

  it "records when card has been touched out" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    is_in_a_station_ready_to_go
    card_has_been_touched_in
    has_moved_to_a_new_station
    card_has_been_touched_out
    card_will_not_show_as_in_use
  end

  it "refuses touch in if insufficient funds" do
    given_a_user_has_a_new_card
    it_will_not_touch_in
  end

  it "deducts minimum fare when card has been touched out" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    card_has_been_touched_in
    min_fare_will_be_deducted_when_touch_out
  end

  it "allows me to view my journey history" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    is_in_a_station_ready_to_go
    card_has_been_touched_in
    has_moved_to_a_new_station
    card_has_been_touched_out
    card_has_been_touched_in_2
    card_has_been_touched_out_2
    i_want_to_see_my_journey_history
  end

  it "will have an empty journey history to begin with" do
    given_a_user_has_a_new_card
    it_has_an_empty_journey_history
  end

  it "allows me to check the zone of the station" do
    given_that_we_have_a_station
    we_can_find_the_zone_of_the_station
  end

  it "allows me to check the name of the station" do
    given_that_we_have_a_station
    we_can_find_the_name_of_the_station
  end

  it "charges a penalty if I touch in but failed out" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    is_in_a_station_ready_to_go
    card_has_been_touched_in
    is_in_a_station_ready_to_go
    the_card_should_be_charged_a_penalty_on_touch_in
  end

  it "charges a penalty if I touch out but failed to touch in" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    has_moved_to_a_new_station
    the_card_should_be_charged_a_penalty_on_touch_out
  end

  it "the journey knows when it is complete" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    is_in_a_station_ready_to_go
    card_has_been_touched_in
    has_moved_to_a_new_station
    card_has_been_touched_out
    the_journey_will_have_completed
  end

  it "the journey calculates a fare" do
    given_a_user_has_a_new_card
    the_card_has_been_topped_up
    is_in_a_station_ready_to_go
    card_has_been_touched_in
    has_moved_to_a_new_station
    card_has_been_touched_out
    the_journey_will_calculate_the_fare
  end

end

def given_a_user_has_a_new_card
  @oc = Oystercard.new
end

def card_should_show_us_the_balance
  expect(@oc.balance).to eq 0
end

def card_can_be_topped_up_and_return_new_balance
  expect(@oc.top_up(500)).to eq 500
end

def card_enforces_maximum_balance
  max_limit = Oystercard::DEFAULT_LIMIT
  @oc.top_up(max_limit)
  expect { @oc.top_up(1) }.to raise_error("Cannot top up over maximum limit (£90)")
end

def the_card_has_been_topped_up
  @oc.top_up(1000)
end

def a_fare_can_be_deducted_from_balance
  expect(@oc.deduct(300)).to eq 700
end

def card_has_been_touched_in
  @journey = Journey.new
  @oc.touch_in(@station, @journey)
end

def card_has_been_touched_in_2
  @journey2 = Journey.new
  @oc.touch_in(@station, @journey2)
end

def card_has_been_touched_out
  @oc.touch_out(@station2, @journey)
end

def card_has_been_touched_out_2
  @oc.touch_out(@station2, @journey2)
end

def card_will_show_as_in_use
  expect(@oc.in_journey?).to be true
end

def card_will_not_show_as_in_use
  expect(@oc.in_journey?).to be false
end

def it_will_not_touch_in
  expect{ @oc.touch_in(@station) }.to raise_error "Insufficient funds on card (required £#{Oystercard::MINIMUM_FARE/100})"
end

def min_fare_will_be_deducted_when_touch_out
  expect { @oc.touch_out(@station) }.to change{ @oc.balance }.by(-Oystercard::MINIMUM_FARE)
end

def is_in_a_station_ready_to_go
  @station = Station.new('Whitechapel', 2)
end

def card_will_know_the_touch_in_station
  expect(@oc.journeys.last.in).to eq @station
end

def has_moved_to_a_new_station
  @station2 = Station.new('Hoxton', 1)
end

def i_want_to_see_my_journey_history
  expect(@oc.journeys).to eq [@journey, @journey2]
end

def it_has_an_empty_journey_history
  expect(@oc.journeys).to eq []
end

def given_that_we_have_a_station
  @station = Station.new('Whitechapel', 2)
end

def we_can_find_the_zone_of_the_station
  expect(@station.zone).to eq 2
end

def we_can_find_the_name_of_the_station
  expect(@station.name).to eq 'Whitechapel'
end

def the_card_should_be_charged_a_penalty_on_touch_in
  expect{ @oc.touch_in(@station) }.to change {@oc.balance}.by -Oystercard::PENALTY
end

def the_card_should_be_charged_a_penalty_on_touch_out
  expect{ @oc.touch_out(@station2) }.to change {@oc.balance}.by -(Oystercard::PENALTY)
end

def the_journey_will_have_completed
  expect(@journey.complete?).to eq true
end

def the_journey_will_calculate_the_fare
  expect(@journey.fare).to eq 100
end
