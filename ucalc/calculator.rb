require 'value'

class Calculator
  attr_accessor :is_calculated

  def initialize start
    @default = start #Value.new 0, Dimension.new
    @stack = []
    @is_calculated = true
  end
  
  def default
    @default.clone
  end
  
  def top
    return default if @stack.size < 1
    @stack[-1]
  end
  
  def push value
    @is_calculated = false
    @stack.push value
  end
  
  def extend value
    start = @is_calculated ? default : top
    pop
    push start.extend(value)
  end
  
  def pop
    @is_calculated = true
    @stack.pop
  end
  
  def plus
    v2 = @stack.pop
    v1 = @stack.pop
    begin
        result = v1 + v2
    rescue
        result = default  
    end
      
    @stack.push(result)
    @is_calculated = true
    self        
  end
  
  def minus
    v2 = @stack.pop
    v1 = @stack.pop
    begin
        result = v1 - v2
    rescue
        result = default  
    end
      
    @stack.push(result)
    @is_calculated = true
    self        
  end
  
  def times
    v2 = @stack.pop
    v1 = @stack.pop
    begin
        result = v1 * v2
    rescue
        result = default  
    end
      
    @stack.push(result)
    @is_calculated = true
    self        
  end
  
  def divide
    v2 = @stack.pop
    v1 = @stack.pop
    begin
        result = v1 / v2
    rescue
        result = default  
    end
      
    @stack.push(result)
    @is_calculated = true
    self        
  end
  
  def binary_op_old op
    v2 = @stack.pop
    v1 = @stack.pop
    begin
        result = op.call(v1,v2)
    rescue
        result = default  
    end
      
    @stack.push(result)
    @is_calculated = true
    self    
  end
  
def swap
  a = top
  pop
  b = top
  pop
  
  push a
  push b
  
  @is_calculated = true
end

  def to_s
    top.to_s
  end
end
