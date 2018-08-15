describe Station do

  let(:subject) { Station.new("Whitechapel", 2)}

  describe '#zone' do
    it 'returns the zone of the station' do
      expect(subject.zone).to eq 2
    end
  end

  describe '#name' do
    it 'returns the name of the station' do
      expect(subject.name).to eq 'Whitechapel'
    end
  end

end
