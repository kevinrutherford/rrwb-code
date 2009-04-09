require 'test/unit'
require 'timer'

class TimerTest < Test::Unit::TestCase
  include Timer

  def test_values_decoded
    interval, time, departure = times 'interval'=>"3", 'duration' => "12", 'departure' => "6"
    assert_equal 3, interval
    assert_equal 12, time
    assert_equal 6, departure
  end

  def test_missing_interval_raises_runtime_error
    assert_raise RuntimeError do
      times 'duration' => "12", 'departure' => "5"
    end
  end

  def test_non_integer_interval_raises_argument_error
    assert_raise ArgumentError do
      times 'interval' => "fred", 'duration' => "12", 'departure' => "5"
    end
    assert_raise ArgumentError do
      times 'interval' => "fred 3", 'duration' => "12", 'departure' => "5"
    end
    assert_raise ArgumentError do
      times 'interval' => "3 fred 3", 'duration' => "12", 'departure' => "5"
    end
  end

  def test_non_positive_interval_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "0", 'duration' => "12", 'departure' => "5"
    end
    assert_raise RuntimeError do
      times 'interval' => "-24", 'duration' => "12", 'departure' => "5"
    end
  end

  def test_missing_duration_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "12", 'departure' => "5"
    end
  end

  def test_non_integer_duration_raises_argument_error
    assert_raise ArgumentError do
      times 'interval' => "3", 'duration' => "sally", 'departure' => "5"
    end
    assert_raise ArgumentError do
      times 'interval' => "3", 'duration' => "sally 12", 'departure' => "5"
    end
    assert_raise ArgumentError do
      times 'interval' => "3", 'duration' => "12sally", 'departure' => "5"
    end
  end

  def test_non_positive_duration_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "3", 'duration' => "0", 'departure' => "5"
    end
    assert_raise RuntimeError do
      times 'interval' => "3", 'duration' => "-33", 'departure' => "5"
    end
  end

  def test_duration_not_a_multiple_of_interval_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "27", 'duration' => "12", 'departure' => "5"
    end
  end

  def test_missing_departure_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "3", 'duration' => "15"
    end
  end

  def test_non_integer_departure_raises_argument_error
    assert_raise ArgumentError do
      times 'interval' => "3", 'duration' => "12", 'departure' => "five"
    end
    assert_raise ArgumentError do
      times 'interval' => "3", 'duration' => "12", 'departure' => "five5"
    end
    assert_raise ArgumentError do
      times 'interval' => "3", 'duration' => "12", 'departure' => "5five"
    end
  end

  def test_non_positive_departure_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "3", 'duration' => "15", 'departure' => "0"
    end
    assert_raise RuntimeError do
      times 'interval' => "3", 'duration' => "33", 'departure' => "-15"
    end
  end

  def test_departure_not_a_multiple_of_interval_raises_runtime_error
    assert_raise RuntimeError do
      times 'interval' => "3", 'duration' => "12", 'departure' => "5"
    end
  end
end
