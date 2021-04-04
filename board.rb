require_relative "piece.rb"
require_relative "nullpiece.rb"
require "colorize"

class Board

    attr_reader :grid
    
    def initialize
        @grid = Array.new(8) { Array.new(8) }
        self.setup
    end


    def setup
        (0...@grid.length).each do |row_idx|
            (0...@grid.length).each do |col_idx|
                if row_idx == 0 || row_idx == 2
                    if col_idx % 2 != 0
                        @grid[row_idx][col_idx] = Piece.new(:black, [row_idx, col_idx], self)
                    else
                        @grid[row_idx][col_idx] = NullPiece.new([row_idx, col_idx], self)
                    end
                elsif row_idx == 1
                    if col_idx % 2 == 0
                        @grid[row_idx][col_idx] = Piece.new(:black, [row_idx, col_idx], self)
                    else
                        @grid[row_idx][col_idx] = NullPiece.new([row_idx, col_idx], self)
                    end
                elsif row_idx == 5 || row_idx == 7
                    if col_idx % 2 == 0
                        @grid[row_idx][col_idx] = Piece.new(:red, [row_idx, col_idx], self)
                    else
                        @grid[row_idx][col_idx] = NullPiece.new([row_idx, col_idx], self)
                    end
                elsif row_idx == 6
                    if col_idx % 2 != 0
                        @grid[row_idx][col_idx] = Piece.new(:red, [row_idx, col_idx], self)
                    else
                        @grid[row_idx][col_idx] = NullPiece.new([row_idx, col_idx], self)
                    end
                else
                    @grid[row_idx][col_idx] = NullPiece.new([row_idx, col_idx], self)
                end
            end
        end
    end

    
    def move_piece(start_pos, end_pos)
        piece = @grid[start_pos[0]][start_pos[1]]
        @grid[end_pos[0]][end_pos[1]] = piece
        @grid[end_pos[0]][end_pos[1]].pos = end_pos
        @grid[start_pos[0]][start_pos[1]] = NullPiece.new([start_pos[0], start_pos[1]], self)
    end


    def render
        (0...@grid.length).each do |row_idx|
            row = ""
            if row_idx % 2 == 0
                (0...@grid.length).each do |col_idx|
                    piece = @grid[row_idx][col_idx]
                    if col_idx % 2 == 0
                        row += (piece.symbol  + '|').colorize(color: piece.color, background: :light_white)
                    else
                        row += (piece.symbol  + '|').colorize(color: piece.color, background: :light_blue)
                    end
                end
            else
                (0...@grid.length).each do |col_idx|
                    piece = @grid[row_idx][col_idx]
                    if col_idx % 2 == 0
                        row += (piece.symbol  + '|').colorize(color: piece.color, background: :light_blue)
                    else
                        row += (piece.symbol  + '|').colorize(color: piece.color, background: :light_white)
                    end
                end
            end
            puts row
        end
    end


    def valid_pos?(pos)
        return true if (0...8).include?(pos[0]) && (0...8).include?(pos[1])
        false
    end


    def empty?(pos)
        return true if @grid[pos[0]][pos[1]].symbol == '_'
        false
    end


    def lost?(color)
        (0...@grid.length).each do |row_idx|
            (0...@grid.length).each do |col_idx|
                if @grid[row_idx][col_idx].color == color
                    return false
                end
            end
        end
        true
    end


    def legal_moves(color)
        legals = []
        (0...@grid.length).each do |row_idx|
            (0...@grid.length).each do |col_idx|
                legals << [row_idx, col_idx] if @grid[row_idx][col_idx].color == color && @grid[row_idx][col_idx].moves.length > 0
            end
        end
        legals
    end

end



# [:black,
#  :light_black,
#  :red,
#  :light_red,
#  :green,
#  :light_green,
#  :yellow,
#  :light_yellow,
#  :blue,
#  :light_blue,
#  :magenta,
#  :light_magenta,
#  :cyan,
#  :light_cyan,
#  :white,
#  :light_white,
#  :default]