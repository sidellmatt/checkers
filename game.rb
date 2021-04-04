require_relative "board.rb"
require_relative "human_player.rb"

class Game

    attr_reader :board, :player_1, :player_2
    
    def initialize
        @board = Board.new
        @player_1 = HumanPlayer.new(:red)
        @player_2 = HumanPlayer.new(:black)
        @current_player = @player_1
    end


    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end


    def play
        until @board.lost?(:red) || @board.lost?(:black)
            @board.render
            puts "Current player: #{@current_player.color}"
            attacked = @current_player.make_move(@board)
            if !attacked
                self.switch_turn
            end
        end
        puts "Game over. "
    end


end

game = Game.new
game.play