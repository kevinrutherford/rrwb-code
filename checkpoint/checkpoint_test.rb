require 'test/unit'
require 'checkpoint'

class Customer
  attr_reader :first, :last, :ssn
  
  def initialize(first, last, ssn)
    @first, @last, @ssn = first, last, ssn
  end
  
  def marries(other)
    @last = other.last
  end
end

class CheckpointTest < Test::Unit::TestCase
  def test_one_variable_changed
    martha = Customer.new "Martha", "Jones", "12-345-6789"
    jack = Customer.new "Jack", "Harkness", "97-865-4321"
    martha.checkpoint
    martha.marries(jack)
    assert_equal({"@last" => "Harkness"}, martha.changes)
  end
end
