require_relative "piece.rb"

class King < Piece

    attr_reader :color, :board, :symbol
    attr_accessor :pos
    
    def initialize(color, pos, board)
        @color = color
        @pos = pos
        @board = board
        @symbol = 'X'
    end


    def moves
        normal_move + attack
    end


    def normal_move
        normal_moves = []
        forward_right = [pos[0] + 1, pos[1] + 1]
        forward_left = [pos[0] + 1, pos[1] - 1]
        back_left = [pos[0] - 1, pos[1] - 1]
        back_right = [pos[0] - 1, pos[1] + 1]
        normal_moves << forward_right if @board.valid_pos?(forward_right) && @board.empty?(forward_right)
        normal_moves << forward_left if @board.valid_pos?(forward_left) && @board.empty?(forward_left)
        normal_moves << back_left if @board.valid_pos?(back_left) && @board.empty?(back_left)
        normal_moves << back_right if @board.valid_pos?(back_right) && @board.empty?(back_right)
        normal_moves
    end


    def attack
        attacks = []
        forward_right = [pos[0] + 1, pos[1] + 1]
        forward_right_2 =[pos[0] + 2, pos[1] + 2]
        
        if @board.valid_pos?(forward_right) && !@board.empty?(forward_right) 
            if @board.grid[pos[0] + 1][pos[1] + 1].color != self.color 
                if @board.valid_pos?(forward_right_2) && @board.empty?(forward_right_2)
                    attacks << forward_right_2
                end
            end
        end

        forward_left = [pos[0] + 1, pos[1] - 1]
        forward_left_2 = [pos[0] + 2, pos[1] - 2]

        if @board.valid_pos?(forward_left) && !@board.empty?(forward_left) 
            if @board.grid[pos[0] + 1][pos[1] - 1].color != self.color 
                if @board.valid_pos?(forward_left_2) && @board.empty?(forward_left_2)
                    attacks << forward_left_2
                end
            end
        end

        back_left = [pos[0] - 1, pos[1] - 1]
        back_left_2 = [pos[0] - 2, pos[1] - 2]

        if @board.valid_pos?(back_left) && !@board.empty?(back_left) 
            if @board.grid[pos[0] - 1][pos[1] - 1].color != self.color 
                if @board.valid_pos?(back_left_2) && @board.empty?(back_left_2)
                    attacks << back_left_2
                end
            end
        end

        back_right = [pos[0] - 1, pos[1] + 1]
        back_right_2 = [pos[0] - 2, pos[1] + 2]

        if @board.valid_pos?(back_right) && !@board.empty?(back_right) 
            if @board.grid[pos[0] - 1][pos[1] + 1].color != self.color 
                if @board.valid_pos?(back_right_2) && @board.empty?(back_right_2)
                    attacks << back_right_2
                end
            end
        end

        attacks
    end

end