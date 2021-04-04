require_relative "king.rb"

class HumanPlayer

    attr_reader :color
    
    def initialize(color)
        @color = color
    end


    def make_move(board)

        attacked = false
        start_arr = []
        end_arr = []

        valid = false
        until valid
            puts "Enter a row number and column number of the piece you would like to move, with a space in between (no brackets). "
            puts "#{board.legal_moves(self.color)}"
            start_pos = gets.chomp
            start_arr = start_pos.split(" ")
            start_arr.each_with_index do |ele, idx| 
                start_arr[idx] = ele.to_i
            end
            valid = true if board.legal_moves(self.color).any? { |subarray| subarray == start_arr }
        end
        
        end_valid = false
        until end_valid
            puts "Enter one of the following valid positions to move your selected piece to. "
            puts "#{board.grid[start_arr[0]][start_arr[1]].moves}"
            end_pos = gets.chomp
            end_arr = end_pos.split(" ")
            end_arr.each_with_index do |ele, idx| 
                end_arr[idx] = ele.to_i
            end
            end_valid = true if board.grid[start_arr[0]][start_arr[1]].moves.include?(end_arr)
        end
        
        attacked = true if board.grid[start_arr[0]][start_arr[1]].attack.include?(end_arr)
        x_difference = end_arr[0] - start_arr[0]
        y_difference =end_arr[1] - start_arr[1]
        if x_difference == 2 && y_difference == 2
            board.grid[start_arr[0] + 1][start_arr[1] + 1] = NullPiece.new([start_arr[0] + 1, start_arr[1] + 1], board)
        elsif x_difference == -2 && y_difference == 2
            board.grid[start_arr[0] - 1][start_arr[1] + 1] = NullPiece.new([start_arr[0] - 1, start_arr[1] + 1], board)
        elsif x_difference == 2 && y_difference == -2
            board.grid[start_arr[0] + 1][start_arr[1] - 1] = NullPiece.new([start_arr[0] + 1, start_arr[1] - 1], board)
        elsif x_difference == -2 && y_difference == -2
            board.grid[start_arr[0] - 1][start_arr[1] - 1] = NullPiece.new([start_arr[0] - 1, start_arr[1] - 1], board)
        end
        
        board.move_piece(start_arr, end_arr)

        if end_arr[0] == 0 && self.color == :red
            board.grid[end_arr[0]][end_arr[1]] = King.new(:red, end_arr, board)
        elsif end_arr[0] == 7 && self.color == :black
            board.grid[end_arr[0]][end_arr[1]] = King.new(:black, end_arr, board)
        end
        
        attacked
    end


end