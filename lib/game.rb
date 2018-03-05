require 'pry'
class Game
  attr_accessor :board, :player_1, :player_2
  attr_reader :token

  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [2,4,6]
  ]

  def initialize(player_1= Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
  def current_player
    (@board.turn_count%2 == 0)? @player_1: @player_2
  end
  def over?
    @board.full?
  end
  def won?
    WIN_COMBINATIONS.find do |win_combination|
      index_0 = win_combination[0]
      index_1 = win_combination[1]
      index_2 = win_combination[2]
        (@board.cells[index_0] == "X" && @board.cells[index_1] == "X" && @board.cells[index_2] == "X") ||
        (@board.cells[index_0] == "O" && @board.cells[index_1] == "O" && @board.cells[index_2] == "O")
      end
    end
  def draw?
    !won? && over?
  end
  def winner
    (won?)? @board.cells[won?[0]]: nil
  end
  def turn
      # binding.pry
      input = current_player.move(@board)
      if @board.valid_move?(input)
        @board.update(input, current_player)
        @board.display
      else
        puts "invalid"
        turn
      end
  end
  def play
    # counter = 1
    # while counter <10
      turn unless won? || draw? || over?
      if winner
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
      # counter +=1
    # end
  end
  def start
    @board.display
    self.play
    # puts "Would you like to play another game?"
    # puts "Type Y for yes, N for no"
    # input = gets.strip
    # self.start unless input == "N".downcase
  end



end
