require_relative 'oystercard'

class Journey




  def initialize(initial_station = nil)
    @initial_station = initial_station
    @exit_station = nil

  end

  def end_journey(final)
    @exit_station = final
  end


  attr_reader :exit_station, :initial_station

  def valid_journey?
    [@initial_station, @exit_station].include?(nil)
  end

  def fare
    valid_journey? ? 6 : 1
  end
end
