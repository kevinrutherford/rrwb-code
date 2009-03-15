require 'calculator'
require 'value'
require 'dimension'

class Calc_Controller

def initialize calculator
  @calculator = calculator
  @calculated = false
end

def digit n 
  @calculator.extend(n)
end

def unit arg
  if @calculator.is_calculated
    @calculator.pop
    @calculator.push(Value.new(0, arg))
  else
    value = @calculator.top
    @calculator.pop
    value *= (Value.new 1, arg)
    @calculator.push value
  end
  
  @calculator.is_calculated = false 
end

def push
  @calculator.push(Value.new(0, Dimension.new))
  @calculator.is_calculated = false 
end

def pop
  @calculator.pop
end

def cab
  a = @calculator.top
  @calculator.pop
  b = @calculator.top
  @calculator.pop
  c = @calculator.top
  @calculator.pop

  @calculator.push b
  @calculator.push a
  @calculator.push c
  
  @calculator.is_calculated = true
end

def swap
  @calculator.swap
end

def plus
  @calculator.plus
end

def subtract
  @calculator.minus
end

def times
  @calculator.times
end

def divide
  @calculator.divide
end

def plus_old
 @calculator.binary_op(lambda{|a,b| a+b})  
end

def to_s
  @calculator.to_s  
end

end
