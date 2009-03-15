require 'test/unit'
require 'simple_queue'

class SimpleQueueTest < Test::Unit::TestCase
  def testQ
    q = SimpleQueue.new
    q.add_rear("E1")
    q.add_rear("E2")
    assert_equal "E1", q.remove_front
    assert_equal "E2", q.remove_front
    assert_equal 0, q.length
  end
end
