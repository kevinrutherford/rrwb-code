require 'csv_writer'
require 'test/unit'

class CsvWriterTest < Test::Unit::TestCase

  def test_writer
    writer = CsvWriter.new
    lines = []
    lines << []
    lines << ['only one field']
    lines << ['two', 'fields']
    lines << ['', 'contents', 'several words included']
    lines << [',', 'embedded , commas, included', 'trailing,']
    lines << ['"', 'embedded " quotes', 'multiple """ quotes""']
    lines << ['mixed commas, and "quotes"', 'simple field']
 
    # Expected:
    # -- (empty line)
    # only one field
    # two,fields
    # ,contents,several words included
    # ",","embedded , commas, included","trailing,"
    # """","embedded "" quotes","multiple """""" quotes"""""
    # "mixed commas, and ""quotes""",simple field

    writer.write(lines)
  end
end
