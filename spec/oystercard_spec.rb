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
      expect { subject.top_up(9500) }.to raise_error("Cannot top up over maximum limit (£90)")
    end

  end
end
