require_relative 'oystercard'

class Journey




  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil

  end

  def end_journey(final)
    @exit_station = final
  end


  attr_reader :exit_station, :entry_station
end
