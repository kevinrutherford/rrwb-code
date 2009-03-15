class Game
  attr_accessor :board

  def initialize(s, position=nil, player=nil)
    @board = s.dup
    @board[position] = player unless position == nil
  end

  def move(player)
    (0..8).each do |i|
      if board[i,1] == '-'
        game = play(i, player)
        return i if game.winner() == player
      end
    end

    (0..8).each { |i| return i if board[i,1] == '-' }
    return -1
  end

  def play(i, player)
    Game.new(board, i, player)
  end

  def winner
    if board[0,1] != '-' && board[0,1] == board[1,1] &&
        board[1,1] == board[2,1]
      return board[0,1]
    end
    if board[3,1] != '-' && board[3,1] == board[4,1] &&
        board[4,1] == board[5,1]
      return board[3,1]
    end
    if board[6,1] != '-' && board[6,1] == board[7,1] &&
        board[7,1] == board[8,1]
      return board[6,1]
    end
    return '-'
  end
end
