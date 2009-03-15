module Checkpoint
  def checkpoint
    @state = var_values
  end

  def var_values
    result = {}
    instance_variables.each do |var|
      result[var] = instance_variable_get var
    end
    result
  end
  
  def changes
    var_values.reject { |k,v| k == "@state" || @state[k] == v }
  end
  
end

class Object
  include Checkpoint
end
