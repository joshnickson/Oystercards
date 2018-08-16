require 'journey_log'

describe JourneyLog do

  let(:in_station) { double :in_station }
  let(:out_station) { double :out_station }
  let(:journey) { double :journey, :in_s= => in_station, :out= => out_station }
  let(:journey_klass) { double :journey_klass, new: journey }
  subject { described_class.new(journey_klass) }


  describe '#initialize' do

    it 'instantiates with empty journey array' do
      expect(subject.journeys).to eq []
    end

  end

  describe '#start' do

    it 'starts a new journey' do
      subject.start(in_station)
      expect(subject.journeys[0]).to eq journey
    end

  end

  describe '#finish' do

    it 'completes a journey' do
      subject.start(in_station)
      subject.finish(out_station)
      expect(subject.journeys.last).to eq journey
    end


  end

end
