require 'oystercard'

describe Oystercard do
    it 'checks new card has balance zero' do
        expect(subject).to respond_to :balance
    end
  
end