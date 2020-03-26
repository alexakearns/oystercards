require_relative 'journey'

class Oystercard
  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = STARTING_BALANCE
    @entry_station = nil
    @journeys = []
    @journey = nil
  end

  attr_reader :balance, :entry_station, :journeys, :journey

  def topup(amount)
    fail "Maximum balance £#{MAXIMUM_BALANCE}" if exceed_max?(amount)

    @balance += amount
  end


  def exceed_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def touch_in(station)
    fail "Below minimum balance of £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    @journey = Journey.new(entry_station: station)
    @entry_station = station
  end

  def touch_out(station)
    @journey.end_journey(station)
    deduct
    @journeys.push(@journey)
    @journey = nil
    @entry_station = nil
    station

  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct
    @journey.valid_journey?
    @balance -= MINIMUM_FARE
  end
end
