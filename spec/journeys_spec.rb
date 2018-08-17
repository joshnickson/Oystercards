require "journey"

describe Journey do

  let(:station) { double :station, zone: 1 }
  let(:bank) { double :bank, zone: 1 }
  let(:chesham) { double :chesham, zone: 9 }

  it 'has an entry station' do
    subject.in_s = station
    expect(subject.in_s).to eq station
  end

  it 'knows when journey is complete' do
    subject.in_s = station
    subject.out = station
    expect(subject.complete?).to eq true
  end

  it 'knows when journey is incomplete' do
    subject.in_s = station
    expect(subject.complete?).to eq false
  end

  it 'calculates a fare' do
    subject.in_s = station
    subject.out = station
    expect(subject.fare).to eq 100
  end

  it 'calculates a penalty fare for a tap-in-only journey' do
    subject.in_s = station
    expect(subject.fare).to eq 600
  end

  it 'calculates a penalty fare for a tap-out-only journey' do
    subject.out = station
    expect(subject.fare).to eq 600
  end

  it 'deducts correct fare for travelling across zones in a complete journey' do
    subject.in_s = bank
    subject.out = chesham
    expect(subject.fare).to eq 900
  end

end
