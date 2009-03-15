require 'test/unit'
require 'template'

class TemplateTest < Test::Unit::TestCase
  include Template

  def test_missing_interval
    puts 'Expected output: Code is 5678901234; alt code is 56789-012'
    template 'Code is %CODE%; alt code is %ALTCODE%', '5678901234'
  end
end
