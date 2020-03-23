class Oystercard
  STARTING_BALANCE = 0

  def initialize
    @balance = STARTING_BALANCE
  end

  attr_reader :balance

  def topup(amount)
    @balance += amount
  end
end
