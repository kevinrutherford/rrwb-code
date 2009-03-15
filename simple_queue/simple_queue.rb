require 'forwardable'

class SimpleQueue
  extend Forwardable

  def initialize
    @elements = []
  end

  def_delegator :@elements, :shift, :remove_front
  def_delegator :@elements, :push, :add_rear
  
  def_delegators :@elements, :clear, :first, :length
end
