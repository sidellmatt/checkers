require_relative "player.rb"

class ComputerPlayer < Player

    def initialize(color)
        @color = color
    end

    def make_move(board)
        attacked = false
        start_pos = board.legal_moves(self.color).sample
        end_pos = board.grid[start_pos[0]][start_pos[1]].moves.sample
        
        attacked = true if board.grid[start_pos[0]][start_pos[1]].attack.include?(end_pos)
        x_difference = end_pos[0] - start_pos[0]
        y_difference =end_pos[1] - start_pos[1]
        if x_difference == 2 && y_difference == 2
            board.grid[start_pos[0] + 1][start_pos[1] + 1] = NullPiece.new([start_pos[0] + 1, start_pos[1] + 1], board)
        elsif x_difference == -2 && y_difference == 2
            board.grid[start_pos[0] - 1][start_pos[1] + 1] = NullPiece.new([start_pos[0] - 1, start_pos[1] + 1], board)
        elsif x_difference == 2 && y_difference == -2
            board.grid[start_pos[0] + 1][start_pos[1] - 1] = NullPiece.new([start_pos[0] + 1, start_pos[1] - 1], board)
        elsif x_difference == -2 && y_difference == -2
            board.grid[start_pos[0] - 1][start_pos[1] - 1] = NullPiece.new([start_pos[0] - 1, start_pos[1] - 1], board)
        end
        
        board.move_piece(start_pos, end_pos)

        if end_pos[0] == 0 && self.color == :red
            board.grid[end_pos[0]][end_pos[1]] = King.new(:red, end_pos, board)
        elsif end_pos[0] == 7 && self.color == :black
            board.grid[end_pos[0]][end_pos[1]] = King.new(:black, end_pos, board)
        end
        
        attacked
    end

end