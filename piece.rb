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
        normal_moves << [pos[0] + direction, pos[1] + 1] if @board.valid_pos?([pos[0] + direction, pos[1] + 1]) && @board.empty?([pos[0] + direction, pos[1] + 1])
        normal_moves << [pos[0] + direction, pos[1] - 1] if @board.valid_pos?([pos[0] + direction, pos[1] - 1]) && @board.empty?([pos[0] + direction, pos[1] - 1])
        normal_moves
    end


    def attack
        attacks = []
        if @board.valid_pos?([pos[0] + direction, pos[1] + 1]) && !@board.empty?([pos[0] + direction, pos[1] + 1]) 
            if @board.grid[pos[0] + direction][pos[1] + 1].color != self.color 
                if @board.valid_pos?([pos[0] + (direction * 2), pos[1] + 2]) && @board.empty?([pos[0] + (direction * 2), pos[1] + 2])
                    attacks << [pos[0] + (direction * 2), pos[1] + 2]
                end
            end
        end
        if @board.valid_pos?([pos[0] + direction, pos[1] - 1]) && !@board.empty?([pos[0] + direction, pos[1] - 1]) 
            if @board.grid[pos[0] + direction][pos[1] - 1].color != self.color 
                if @board.valid_pos?([pos[0] + (direction * 2), pos[1] - 2]) && @board.empty?([pos[0] + (direction * 2), pos[1] - 2])
                    attacks << [pos[0] + (direction * 2), pos[1] - 2]
                end
            end
        end
        attacks
    end


end