require 'csv_formatter'
require 'test/unit'

class CsvFormatterTest < Test::Unit::TestCase

  def setup
    @csv = CsvFormatter.new
  end

  def test_no_lines
    assert_equal("", @csv.format([]))
  end

  def test_no_quotes_or_commas
    assert_equal("", @csv.format([[]]))
    assert_equal("only one field",
      @csv.format([["only one field"]]))
    assert_equal("two,fields",
      @csv.format([["two", "fields"]]))
    assert_equal(",contents,several words included",
      @csv.format([["", "contents", "several words included"]]))
    assert_equal("two\nlines",
      @csv.format([["two"], ["lines"]]))
  end

  def test_commas_and_quotes
    assert_equal('",","embedded , commas","trailing,"',
      @csv.format([[',', 'embedded , commas', 'trailing,']]))
    assert_equal('"""","multiple """""" quotes"""""',
      @csv.format([['"', 'multiple """ quotes""']]))
    assert_equal('"commas, and ""quotes""",simple',
      @csv.format([['commas, and "quotes"', 'simple']]))
  end
end
