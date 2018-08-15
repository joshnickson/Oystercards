require "journeys"

describe Journey do

  let(:station) { double :station }

  it 'has an entry station' do
    subject.in = station
    expect(subject.in).to eq station
  end

  it 'knows when journey is complete' do
    subject.in = station
    subject.out = station
    expect(subject.complete?).to eq true
  end

  it 'knows when journey is incomplete' do
    subject.in = station
    expect(subject.complete?).to eq false
  end

  # it calculates a fare

end
