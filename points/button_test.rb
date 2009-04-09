require 'button.rb'
require 'test/unit'

class ButtonTest < Test::Unit::TestCase
  def test_button_stays_in_bounds
    button = Button.new('Click here', 50, 75)
    button.move_to(100, 78)
    assert_equal(0, button.x)
    assert_equal(3, button.y)
  end

  def test_negative_positions_moved_positive
    button = Button.new('New', 100, 15)
    button.move_to(-15, -5)
    assert_equal(85, button.x)
    assert_equal(10, button.y)
  end
end

