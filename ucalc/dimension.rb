class Dimension
  attr_reader :dimensions

  def initialize unit2int={}
    @dimensions = new_hash(unit2int)
  end
  
  def clone
    Dimension.new(new_hash(@dimensions))
  end
  
  def ==(other)
    return dimensions == other.dimensions
  end
  
  def *(other)
      new_dimensions = new_hash(dimensions)
      other.dimensions.each_pair {
        |key, value|
        sum = dimensions[key] + value
        new_dimensions[key] = sum
        new_dimensions.delete(key) if sum == 0
      }
      Dimension.new new_dimensions
  end
  
  def -@
    new_dimensions = new_hash(dimensions)
    dimensions.each_pair{
      |key, value|
      new_dimensions[key] = -value
    }
    Dimension.new new_dimensions  
  end
  
  def /(other)
    self * -other
  end

  def to_s
    return "" if dimensions.size == 0
    
    positives = ""
    negatives = ""

    dimensions.each{|key, value|
      positives += '*' + format(key, value)  if value > 0
      negatives += '*' + format(key, -value) if value < 0
    }
    
    if (positives.length == 0)
      positives = "1"
    else
      positives = positives[1..-1]
    end
    
    if (negatives.length > 0)
      negatives = negatives[1..-1]
    end
    
    return positives if (negatives.length == 0)
    return positives + "/" + negatives
  end

  def format key, value
    return key if value == 1
    return key + "^" + value.to_s  
  end
  
  private
  def new_hash initial_value
    result = Hash.new{|hash, key| hash[key] = 0 }
    result.merge!(initial_value)
    result
  end  
end
