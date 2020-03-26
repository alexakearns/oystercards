require 'journey'
require 'station'

describe Journey do

  subject {Journey.new(entry_station: "Bank")}
  let(:bank) { Station.new((name:'Bank', zone:1))}
  let(:hammersmith) { Station.new((name:'Hammersmith', zone:4))}


    it 'starts a new journey when #touch_in on Oystercard' do
      expect(subject.entry_station).to eq "Bank"
    end

    it "should be able to tell me the exit station of the journey if present" do
      expect(subject.exit_station).to be
    end
    it "should be able to accept an exit station" do
      expect(subject).to respond_to(:end_journey).with(1).argument
    end
    it "should be able to return the exit station that it was passed." do
      expect { subject.end_journey('buh') }.to change { subject.exit_station }.from("").to('buh')
    end

    describe "fare calculations" do
      it 'should tell you if the journey is valid' do
        journey = Journey.new(entry_station: bank)
        journey.end_journey(hammersmith)
      end
    end
# need to amend journey tests to work with nil from "" create fare method in journey
# update end_journey and create valid_journey?
=begin
    it 'registers exit_station at #touch_out on Oystercard' do
      card.touch_out("Bow")
      expect(subject.exit_station).to eq card.exit_station
    end

=end

 # touch in successfull and touch out successfully return a journey
end

=begin
  exit_station
  close jounrey

  successful journey == entry_station Has a value, exit_station Has a value

  when touch in if exit station has a value return journey

  when touch_out if entry_station doesn't have a value return the journey

=end
