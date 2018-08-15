require "journeys"

describe Journey do

  let(:station) { double :station }

  it 'has an entry station' do
    subject.in = station
    expect(subject.in).to eq station
  end

end
