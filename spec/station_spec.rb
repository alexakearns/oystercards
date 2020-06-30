require 'station'

describe Station do

  subject {Station.new(name: "Bank", zone: 1)}

  context 'station location' do
    it 'station has a name' do
      expect(subject.name).to eq ("Bank")
    end

    it 'station has a zone' do
      expect(subject.zone).to eq (1)
    end
  end

end