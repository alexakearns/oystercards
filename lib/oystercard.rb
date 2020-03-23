class Oystercard
  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = STARTING_BALANCE
  end

  attr_reader :balance

  def topup(amount)
    fail 'Maximum balance exceeded' if exceed_max?(amount)
    @balance += amount
  end

  def exceed_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end
end
