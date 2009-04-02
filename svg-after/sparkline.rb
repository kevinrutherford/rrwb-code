require 'svg'

class Sparkline

  def initialize(y_values)
    @height_above_x_axis = y_values.max
    @height_below_x_axis = y_values.min
    @final_value = y_values[-1]
    @y_values = reflect_top_and_bottom(y_values)
  end

  def reflect_top_and_bottom(y_values)
    y_values.map { |y| -y }
  end

  def to_svg
    %Q{<svg xmlns="http://www.w3.org/2000/svg"
          xmlns:xlink="http://www.w3.org/1999/xlink" >
       <g transform="translate(0,#{@height_above_x_axis})">
         #{x_axis}
         #{sparkline}
         #{spark}
	   </g>
    </svg>}
  end

private

  def x_axis
    "<!-- x-axis -->
    #{SVG.line(0, 0, @y_values.length, 0, '#999', 1)}"
  end

  def sparkline
    points = []
    @y_values.each_index { |i| points << "#{i},#{@y_values[i]}" }
    "<!-- sparkline -->
     #{SVG.polyline(points, 'none', '#333', 1)}"
  end

  SQUARE_SIDE = 4
  SPARK_COLOR = 'red'

  def spark
    centre_x = @y_values.length-1
    centre_y = @y_values[-1]
    rect = SVG.rect(centre_x-(SQUARE_SIDE/2),
        centre_y-(SQUARE_SIDE/2),
        SQUARE_SIDE, SQUARE_SIDE, SPARK_COLOR, 'none', 0)
    text = SVG.text(centre_x+6, centre_y+4, @final_value,
        'Verdana', 9, SPARK_COLOR)
    "<!-- spark -->
     #{rect}
     <!-- final value -->
     #{text}"
  end

end
