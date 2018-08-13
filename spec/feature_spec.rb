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
  expect { @oc.top_up(9500) }.to raise_error("Cannot top up over maximum limit (£90)")
end
