class Oystercard
  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = STARTING_BALANCE
  end

  attr_reader :balance

  def topup(amount)
    fail "Maximum balance £#{MAXIMUM_BALANCE}" if exceed_max?(amount)
    @balance += amount
  end

  def deduct(fare)
#    fail "Insufficient balance, your balance is £#{@balance}" if insufficient_funds?(fare)
    @balance -= fare
  end

#  def insufficient_funds?(amount)
#    balance - amount.negative?
#  end

  def exceed_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def touch_in
  end
end
