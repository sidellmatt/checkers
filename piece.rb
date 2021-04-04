class Piece

    attr_reader :color, :symbol, :board
    attr_accessor :pos
    
    def initialize(color, pos, board)
        @color = color
        @symbol = 'O'
        @pos = pos
        @board = board
    end


    def moves
        normal_move + attack
    end


    def direction
        direction = 0
        if self.color == :black
            direction = 1
        elsif self.color == :red
            direction = -1
        end
        direction
    end


    def normal_move
        normal_moves = []
        forward_right = [pos[0] + direction, pos[1] + 1]
        forward_left = [pos[0] + direction, pos[1] - 1]
        normal_moves << forward_right if @board.valid_pos?(forward_right) && @board.empty?(forward_right)
        normal_moves << forward_left if @board.valid_pos?(forward_left) && @board.empty?(forward_left)
        normal_moves
    end


    def attack
        attacks = []
        forward_right = [pos[0] + direction, pos[1] + 1]
        forward_right_2 =[pos[0] + (direction * 2), pos[1] + 2]
        
        if @board.valid_pos?(forward_right) && !@board.empty?(forward_right) 
            if @board.grid[pos[0] + direction][pos[1] + 1].color != self.color 
                if @board.valid_pos?(forward_right_2) && @board.empty?(forward_right_2)
                    attacks << forward_right_2
                end
            end
        end

        forward_left = [pos[0] + direction, pos[1] - 1]
        forward_left_2 = [pos[0] + (direction * 2), pos[1] - 2]

        if @board.valid_pos?(forward_left) && !@board.empty?(forward_left) 
            if @board.grid[pos[0] + direction][pos[1] - 1].color != self.color 
                if @board.valid_pos?(forward_left_2) && @board.empty?(forward_left_2)
                    attacks << forward_left_2
                end
            end
        end

        attacks

    end


end