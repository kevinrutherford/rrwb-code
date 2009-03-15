require 'dimension'

class Value
  attr_reader :number, :dimension
  
  def initialize number, dimension
    @number = number
    @dimension = dimension
  end
  
  def clone
    Value.new(@number, @dimension.clone)
  end
  
  def extend v
    return Value.new(number * 10 + v, dimension) if v.kind_of? Integer
    return Value.new(number, dimension * v)
  end
  
  def +(other)
    raise "can't mix apples and oranges" if dimension != other.dimension
    Value.new(number + other.number, dimension)
  end
  
  def -(other)
    raise "can't mix apples and oranges" if dimension != other.dimension
    Value.new(number - other.number, dimension)
  end
  
  def *(other)
    Value.new(number * other.number, dimension * other.dimension)
  end
  
  def /(other)
    Value.new(number / other.number, dimension / other.dimension)
  end
  
  def ==(other)
    (number == other.number) and (dimension == other.dimension)
  end
  
  def dimension
    @dimension
  end
  
  def to_s
    suffix = @dimension.to_s
    return @number.to_s if suffix.size == 0
    @number.to_s + '*' + @dimension.to_s
  end
  
end
