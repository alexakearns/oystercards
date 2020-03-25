require_relative 'journey'

class Oystercard
  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = STARTING_BALANCE
    @in_use = false
    @entry_station = nil
    @journeys = []
 
  end

  attr_reader :balance, :entry_station, :journeys

  def topup(amount)
    fail "Maximum balance £#{MAXIMUM_BALANCE}" if exceed_max?(amount)

    @balance += amount
  end


  def exceed_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def touch_in(station)
    fail "Below minimum balance of £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    journey = Journey.new(entry_station: station)
    @in_use = true
    @entry_station = station
  end

  def touch_out(station)
    deduct
    @in_use = false
    @journeys << {entry: @entry_station, exit: station }
    @entry_station = nil
    station

  end

  def in_journey?
    !!entry_station
  end

  private 
  
  def deduct
    @balance -= MINIMUM_FARE
  end
end
