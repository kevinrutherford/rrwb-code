# bird.rb
require 'point.rb'

class Bird
  attr_accessor :location

  def initialize max_x, max_y
    @@max_x = max_x 
    @@max_y = max_y
    @location = Point.new 0, 0
  end

  def move_by(point)
    @location.x = (@location.x + point.x) % @@max_x
    @location.y = (@location.y + point.y) % @@max_y
  end
end
