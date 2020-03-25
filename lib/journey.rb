require_relative 'oystercard'

class Journey




  def initialize(entry_station:)
    @entry_station = entry_station
    @exit_station = ""

  end

  attr_accessor :entry_station 

  def exit_station
    oystercard.exit_station
  end

end