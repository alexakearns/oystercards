require 'oystercard'

describe Oystercard do

#  let(:card_tenner) { Oystercard.new.topup(10) }
  let(:entry_station) { double :station, :touch_in => 'Entered Bow'}

  context '#balance' do
    it 'responds to #balance' do
      expect(subject).to respond_to :balance
    end
    it 'a newly created card has a balance of 0' do
      expect(subject.balance).to be 0
    end
  end

  context '#topup' do
    it 'responds to #topup' do
      expect(subject).to respond_to :topup
    end
    it 'expects an argument, the amount to add to balance' do
      expect(subject).to respond_to(:topup).with(1).argument
    end
    it 'returns a new value of balance with the amount added' do
      expect { subject.topup(5) }.to change { subject.balance }.by(5)
    end

  end

  context 'testing max and min limits of card' do
   
    it 'card has maximum balance and raises error if exceeded' do
      subject.topup(Oystercard::MAXIMUM_BALANCE)
      expect { subject.topup(1) }.to raise_error "Maximum balance £#{Oystercard::MAXIMUM_BALANCE}"
    end

    it 'will raise an error if there is not enough balance on the card' do
      expect { subject.touch_in(entry_station) }.to raise_error "Below minimum balance of £#{Oystercard::MINIMUM_BALANCE}"
    end
    
  end

  context '#in_journey' do
    it 'responds to touch_in' do
      expect(subject).to respond_to :touch_in
    end
    it 'responds to touch_out' do
      expect(subject).to respond_to :touch_out
    end

    it 'responds to in_journey?' do
      expect(subject).to respond_to :in_journey?
    end

    context 'adds 10 to balance and touches in' do
      
      before do
        subject.topup(10)
        subject.touch_in(entry_station)
      end 

        it 'it checks if the card in use after user touched in' do
          expect(subject).to be_in_journey
        end
        it 'it checks if the card not in use after user touched out' do
          subject.touch_out
          expect(subject).not_to be_in_journey
        end
        it 'when use touches out, the correct amount is deducted from the balance' do
          expect { subject.touch_out }.to change { subject.balance }.by -(Oystercard::MINIMUM_FARE)
        end
        it 'records station entered at touch_in' do
          expect(subject.entry_station).to eq entry_station
        end
    
        it 'entry station returns to nil when #touch_out' do
         subject.touch_out
         expect(subject.entry_station).to eq nil
        end
    end
  end 

  context 'stations' do

    it 'recalls entry station at touch_in' do
      subject.topup(10)
      expect(subject.touch_in(entry_station)).to eq entry_station
    end

  end

end

