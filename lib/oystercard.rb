require_relative 'journey'

class Oystercard
  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  MAXIMUM_FARE = 6

  def initialize
    @balance = STARTING_BALANCE

    @journeys = []
    @journey = nil
  end

  attr_reader :balance, :journeys, :journey

  def topup(amount)
    fail "Maximum balance £#{MAXIMUM_BALANCE}" if exceed_max?(amount)

    @balance += amount
  end


  def exceed_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def touch_in(station)
    fail "Below minimum balance of £#{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    skipped_touch_out
    @journey = Journey.new(station)
  end

  def touch_out(station)
    skipped_touch_in(station)
    deduct
    @journey = nil
  end

  def in_journey?
    @journey != nil
  end

  private

  def deduct
    @balance -= @journey.fare
    @journeys.push(@journey)
  end

  def skipped_touch_out
    @journey == nil ? nil : self.deduct
  end

  def skipped_touch_in(station)
     @journey == nil ? @journey = Journey.new : nil
     @journey.end_journey(station)
   end
 end
