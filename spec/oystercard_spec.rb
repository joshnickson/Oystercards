require "oystercard"
describe Oystercard do

  describe "#balance" do
    it { is_expected.to respond_to(:balance) }

    it "creates new card with balance 0" do
      expect(subject.balance).to eq 0
    end

  end

  describe "#add_money" do
    it "allows users to add money to their oystercard" do
      expect(subject.top_up(500)).to eq 500
    end

    it "enforces maximum balance limit" do
      max_balance = Oystercard::DEFAULT_LIMIT
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error("Cannot top up over maximum limit (£90)")
    end
  end
  describe "#deduct" do
    it "deducts the fare amount from the card balance" do
      subject.top_up(1000)
      expect(subject.deduct(300)).to eq 700
    end
  end

  describe "#touch_in" do
    it "changes value of in_journey to true" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "will not allow touch in if insufficient funds" do
      p subject.balance
      expect{ subject.touch_in }.to raise_error "Insufficient funds on card (required £#{Oystercard::MINIMUM_FARE/100})"
    end
  end

  describe "#touch_out" do
    it "changes value of in_journey to false" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
