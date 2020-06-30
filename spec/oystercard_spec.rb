require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:final_station) { double :station }

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
          subject.touch_out(final_station)
          expect(subject).not_to be_in_journey
        end
        it 'when use touches out, the correct amount is deducted from the balance' do
          expect { subject.touch_out(final_station) }.to change { subject.balance }.by -(Oystercard::MINIMUM_FARE)
        end

        it 'entry station returns to nil when #touch_out' do
         subject.touch_out(final_station)
         expect(subject.journey).to eq nil
        end

        it 'recalls journey start after journey completed' do
          subject.touch_out(final_station)
          expect(subject.journeys[-1].initial_station).to eq(entry_station)
        end

        it 'recalls journey finish after journey completed' do

          subject.touch_out(final_station)
          expect(subject.journeys[-1].exit_station).to eq(final_station)
        end
    end
  end

  context 'stations' do

    it 'checks that the card has an empty list of journeys by default' do
      expect(subject.journeys).to eq []
    end

  end

  context 'journey class connectivity' do
    it "after touching in the journey has the entry station stored in it." do
      subject.topup(5)
      subject.touch_in('bank')
      expect(subject.journey.initial_station).to eq('bank')
    end
    it 'after touching out the journey is equal to nil' do
      subject.topup(5)
      subject.touch_in('bank')
      subject.touch_out('hammersmith')
      expect(subject.journey).to eq nil
    end
    it 'should store the exit station upon touching out' do
      c = Oystercard.new
      c.topup(5)
      c.touch_in('bank')
      c.touch_out('hammersmith')
      expect(c.journeys[-1].exit_station).to eq('hammersmith')
    end
  end

  context 'fare dodgers' do
    it 'should charge you the max fare if you touch in twice in a row' do
      c = Oystercard.new
      c.topup(5)
      c.touch_in('bank')
      expect { c.touch_in('hub') }.to change { c.balance }.by(-Oystercard::MAXIMUM_FARE)
    end
    it 'should charge you the max fare if you touch out without touching in'do
      c = Oystercard.new
      c.topup(5)
      expect { c.touch_out('buh')}.to change { c.balance }.by(-Oystercard::MAXIMUM_FARE)
    end
  end

end
