require 'sparkline'

def zero_or_one() rand(2) end

def one_or_minus_one
  (zero_or_one * 2) - 1
end

def next_value(y_values)
  y_values[-1] + one_or_minus_one
end

def y_values
  result = [0]
  1000.times { result << next_value(result) }
  result
end

puts Sparkline.new(y_values).to_svg
