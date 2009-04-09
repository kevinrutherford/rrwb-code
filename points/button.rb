#button.rb
require 'point.rb'

class Button
  attr_accessor :name
  attr_accessor :x, :y

  def initialize name, x_limit, y_limit
    @name = name
    @xmax = x_limit
    @ymax = y_limit
    @x = 0
    @y = 0
  end

  def move_to(x, y)
    @x = limit(x, @xmax) 
    @y = limit(y, @ymax)
  end

private
  def limit(v, vmax)
    result = v
    while result >= vmax
      result -= vmax
    end
    while result < 0
      result += vmax
    end
    result
  end
end
