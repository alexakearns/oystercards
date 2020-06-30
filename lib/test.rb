Oyster card

def touch_in(entry_station)
  @journey = Journey.new(entry_station)
end

def touch_out(exit_station)

  @journey.exit_station = exit_station

end





journey

class Journey

  attr_accessor :entry_station, :ex_station

  def initialize
    

  end



end