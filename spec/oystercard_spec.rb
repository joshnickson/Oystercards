require "oystercard"
describe Oystercard do

  let(:max_bal)  { Oystercard::DEFAULT_LIMIT }
  let(:min_fare) { Oystercard::MINIMUM_FARE }

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
      subject.top_up(max_bal)
      expect { subject.top_up(1) }.to raise_error("Cannot top up over maximum limit (£90)")
    end
  end
  # describe "#deduct" do
  #   it "deducts the fare amount from the card balance" do
  #     subject.top_up(1000)
  #     expect(subject.deduct(300)).to eq 700
  #   end
  # end

  describe "#touch_in" do
    it "changes value of in_journey to true" do
      subject.top_up(min_fare)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "will not allow touch in if insufficient funds" do
      expect{ subject.touch_in }.to raise_error "Insufficient funds on card (required £#{min_fare/100})"
    end
  end

  describe "#touch_out" do

    before do
      subject.top_up(min_fare)
      subject.touch_in
    end

    it "changes value of in_journey to false" do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "deducts minimum fare from balance" do
      expect { subject.touch_out }.to change{ subject.balance }.by(-min_fare)
    end

  end

end
