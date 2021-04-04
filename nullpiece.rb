require_relative "piece.rb"

class NullPiece < Piece

    attr_reader :color, :symbol
    attr_accessor :pos
    
    def initialize(pos, board)
        @color = :light_black
        @symbol = '_'
        @pos = pos
        @board = board
    end

end