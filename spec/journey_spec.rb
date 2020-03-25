require 'journey'
require 'oystercard'

describe Journey do

  subject {Journey.new(entry_station: "Bank")}
  let(:card) { Oystercard.new}

  context 'new Oystercard topped up to £5' do

    before do
      card.topup(5)
      card.touch_in("Bank")
    end

    it 'starts a new journey when #touch_in on Oystercard' do     
      expect(subject.entry_station).to eq "Bank"
    end

=begin
    it 'registers exit_station at #touch_out on Oystercard' do
      card.touch_out("Bow")
      expect(subject.exit_station).to eq card.exit_station
    end

=end

  end

 # touch in successfull and touch out successfully return a journey 
end

=begin
  exit_station
  close jounrey
  
  successful journey == entry_station Has a value, exit_station Has a value
  
  when touch in if exit station has a value return journey

  when touch_out if entry_station doesn't have a value return the journey

=end