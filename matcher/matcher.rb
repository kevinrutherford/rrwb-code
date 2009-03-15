class Matcher
  def match(expected, actual, clip_limit, delta) 
    # Clip "too-large" values
    actual = actual.map { |val| [val, clip_limit].min }

    # Check for length differences
    return false if actual.length != expected.length

    # Check that each entry is within expected +/- delta
    actual.each_index { |i|
      return false if (expected[i] - actual[i]).abs > delta
    }
    return true
  end
end
