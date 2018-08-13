require "oystercard"

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

  it "deducts fare from card balance" do
    given_a_user_has_a_new_card
    and_the_card_has_been_topped_up
    a_fare_can_be_deducted_from_balance
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

def and_the_card_has_been_topped_up
  @oc.top_up(1000)
end

def a_fare_can_be_deducted_from_balance
  expect(@oc.deduct(300)).to eq 700
end