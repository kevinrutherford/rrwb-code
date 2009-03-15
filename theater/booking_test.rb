require 'agency'
require 'theater'
require 'test/unit'

class BookingTest < Test::Unit::TestCase
  def test_two_seats_anywhere
    adelphi = Theater.new('x-xxxx-xxxx')
    assert_equal([1,6], Agency.book(2, adelphi))
  end
end
