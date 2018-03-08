require 'pry'
module Players

  class Computer < Player
    WIN_COMBINATIONS = [
      [0,1,2], [3,4,5], [6,7,8],
      [0,3,6], [1,4,7], [2,5,8],
      [0,4,8], [2,4,6]
    ]
    #////////////AS PLAYER_1//////////////////////
    def corner_move(board)
      first_move = [1,3,7,9].sample.to_s
      first_move
    end

    def opposite_corner(board)
     if board.position(1) == self.token
       "9" unless (board.position(9) != self.token && board.taken?(9))
       ["7","3"].sample
     elsif board.position(3) == self.token
       "7" unless (board.position(7) != self.token && board.taken?(7))
       ["1","9"].sample
     elsif board.position(7) == self.token
       "3" unless (board.position(3) != self.token && board.taken?(3))
       ["7","3"].sample
     elsif board.position(9) == self.token
       "1"unless (board.position(1) != self.token && board.taken?(1))
       ["1","9"].sample
     end
   end
   #<<<<<<<<<<<block_move>>>>>>>>>>>>>>
   def center_move(board)
     if !board.taken?(5)
       "5"
     end
   end
   #<<<<<<<<<<<block_move>>>>>>>>>>>>>>
   def edge_move(board)
     #possibly third move
     if !board.taken?(3) && !board.taken?(7)
       #if 3 and 7 are available choose 1
       third_move = [3,7].sample.to_s
       third_move
     elsif board.taken?(3)
      #if 3 is taken move to 7
       "7"
     elsif board.taken?(7)
       #if 7 is taken move to 3
       "3"
     end
   end
   def win_move(board)
     win_1 = WIN_COMBINATIONS.detect do |combo|
    		       input_1 = combo[0]
    		       input_2 = combo[1]
    		       input_3 = combo[2]
    		       board.cells[input_1] == self.token && board.cells[input_2] == self.token && board.cells[input_3] == " "
  	        end
     win_2 = WIN_COMBINATIONS.detect do |combo|
  			       input_1 = combo[0]
  			       input_2 = combo[1]
  			       input_3 = combo[2]
  			       board.cells[input_2] == self.token && board.cells[input_3] == self.token && board.cells[input_1] == " "
  	        end
   	win_3 = WIN_COMBINATIONS.detect do |combo|
           	 input_1 = combo[0]
           	 input_2 = combo[1]
           	 input_3 = combo[2]
           	 board.cells[input_1] == self.token && board.cells[input_3] == self.token && board.cells[input_2] == " "
           	end
       if win_1
            (win_1.detect{|i| board.cells[i]==" "}+1).to_s
       elsif win_2
       	    (win_2.detect{|i| board.cells[i]==" "}+1).to_s
       elsif win_3
       	    (win_3.detect{|i| board.cells[i]==" "}+1).to_s
       end
    end
    def valid_move(board)
      valid_move = board.cells.map.with_index(1) do |v, i|
          if v == " "
            i.to_s
          end
        end
      end
    def move(board)
        if board.turn_count == 0
          corner_move(board)
        elsif board.turn_count == 1
          corner_move(board) || center_move(board)
        elsif board.turn_count == 2
          opposite_corner(board)
        elsif board.turn_count == 3
          "8" unless board.taken?(8) || "2" unless board.taken?(2)
        elsif board.turn_count == 4
          moves = [win_move(board),edge_move(board),valid_move(board)]
          # binding.pry
          moves.find{|move| board.valid_move?(move)}
        elsif board.turn_count == 5
          "3" unless board.taken?(3) || "7" unless board.taken?(7)
        elsif board.turn_count == 6
          binding.pry
          win_move(board) unless board.valid_move?(win_move(board)) ||
          valid_move(board) unless board.valid_move?(valid_move(board))
        elsif board.turn_count == 7
          "3" unless board.taken?(3) || "7" unless board.taken?(7)
        else
          win_move(board) unless board.valid_move?(win_move(board)) ||
          valid_move(board) unless board.valid_move?(valid_move(board))
        end
    end
  end
end
