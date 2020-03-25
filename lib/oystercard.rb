
class Oystercard
  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = STARTING_BALANCE
    @in_use = false
    @entry_station = nil
  end

  attr_reader :balance, :entry_station

  def topup(amount)
    fail "Maximum balance £#{MAXIMUM_BALANCE}" if exceed_max?(amount)

    @balance += amount
  end


  def exceed_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def touch_in(station)
    fail "Below minimum balance of £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    @in_use = true
    @entry_station = station
  end

  def touch_out
    deduct
    @in_use = false
    @entry_station = nil
  end

  def in_journey?
    @in_use
  end

  private 
  
  def deduct
    @balance -= MINIMUM_FARE
  end
end
