require 'array_queue'
require 'test/unit'

class ArrayQueueTest < Test::Unit::TestCase
  def test_queue_invariant
    q = ArrayQueue.new
    q.add_rear("E1")
    q.add_rear("E2")
    assert_equal("E1", q.remove_front)
    assert_equal("E2", q.remove_front)
    assert_equal(0, q.length)
  end
end
