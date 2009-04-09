require 'bird'
require 'test/unit'

class BirdTest < Test::Unit::TestCase
  def test_location_wraps
    bird = Bird.new 100, 200
    bird.move_by(Point.new(80, 100))
    bird.move_by(Point.new(50, 100))
    assert_equal(30, bird.location.x)
    assert_equal(0, bird.location.y)
  end
end

