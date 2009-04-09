require 'matcher'
require 'test/unit'

class MatcherTest < Test::Unit::TestCase

	def setup
		@numbers = [10, 50, 30, 98]
	end

  def test_different_lengths_rejected
    assert !Matcher.new.match(@numbers, @numbers + [1], 100, 5)
    assert !Matcher.new.match(@numbers + [1], @numbers, 100, 5)
  end

  def test_different_lengths_rejected_with_clipping
    @numbers << 103
    assert !Matcher.new.match(@numbers, @numbers + [1], 100, 5)
    assert !Matcher.new.match(@numbers + [1], @numbers, 100, 5)
  end

  def test_variation_within_delta_accepted
    assert Matcher.new.match(@numbers, [12, 55, 25, 100], 100, 5)
  end

  def test_clipped_variation_within_delta_accepted
    assert Matcher.new.match(@numbers, [12, 55, 25, 110], 100, 5)
  end

  def test_variation_greater_than_delta_rejected
    assert !Matcher.new.match(@numbers, [10, 60, 30, 98], 100, 5)
  end

end
