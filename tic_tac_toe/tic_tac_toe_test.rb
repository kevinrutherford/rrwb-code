require 'test/unit'
require 'tic_tac_toe'

class GameTest < Test::Unit::TestCase

  def test_default_move
    game = Game.new("XOX" +
                    "OX-" +
                    "OXO")
    assert_equal(5, game.move('X'))

    game = Game.new("XOX" + 
                    "OXO" + 
                    "OX-")
    assert_equal(8, game.move('O'))

    game = Game.new("---" + 
                    "---" + 
                    "---")
    assert_equal(0, game.move('X'))

    game = Game.new("XXX" + 
                    "XXX" + 
                    "XXX")
    assert_equal(-1, game.move('X'))
  end

  def test_find_winning_move
    game = Game.new("XO-" + 
                    "XX-" + 
                    "OOX")
    assert_equal(5, game.move('X'))
  end

  def test_win_conditions
    game = Game.new("---" + 
                    "XXX" + 
                    "---")
    assert_equal('X', game.winner())
  end
end
