class Theater
  attr_reader :seats

  def initialize(seats)
    @seats = seats.split(//)
  end  
end
