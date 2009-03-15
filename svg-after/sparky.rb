require 'sparkline'

def zero_or_one
  rand(2)
end

def one_or_minus_one
  (zero_or_one * 2) - 1
end

def y_values
  result = [0]
  1000.times { result << result[-1] + one_or_minus_one }
  result
end

puts Sparkline[y_values].to_svg
