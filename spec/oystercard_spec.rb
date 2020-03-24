require 'oystercard'

describe Oystercard do

#  let(:card_tenner) { Oystercard.new.topup(10) }

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
    it 'restricts topup so max balance is £90' do
      expect {subject.topup(described_class::MAXIMUM_BALANCE + 1) }.to raise_error "Maximum balance £#{described_class::MAXIMUM_BALANCE}"
    end
  end

  context '#deduct' do
    it 'responds to #deduct' do
      expect(subject).to respond_to :deduct
    end
    it 'takes one argument, the fare to deduct' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end
    it 'returns a new value of balance with the fare deducted' do
      expect { subject.deduct(5) }.to change { subject.balance }.by -5 
    end
#    it 'will raise an error if there is not enough balance on the card' do
#      expect { subject.deduct(5) }.to raise_error 'Insufficient balance, your balance is £0'
#    end
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
  
  
  end



end
