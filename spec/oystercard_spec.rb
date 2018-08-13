require "oystercard"
describe Oystercard do
  describe "#add_money" do
    it { is_expected.to respond_to(:add_money) }
  end

  describe "#balance" do
    it { is_expected.to respond_to(:balance) }

    it "creates new card with balance 0" do
      expect(subject.balance).to eq 0
    end

  end

end
