# our main class will be def here w/ all data & logic req
require 'pry'
class TicTacToe
    
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    ## 0 1 2
    ## 3 4 5
    ## 6 7 8 
    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
        [2, 5 ,8], [0, 4, 8], [2, 4, 6]
    ] # array of arrays indexes into another array

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    def input_to_index(string)
        @choice = string.to_i-1 # turns choice from str. to int., -1 from players choice to match index
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == "X" || @board[index] == "O"
            true
        else
            false
        end
        # @board[index] != " " would work also
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
        # if position is not taken, it's a valid move
    end

    def turn_count
        @board.count do |position|
            position != " "
        end
    end

    def current_player
        turn_count.even? ? "X" : "O" # ternary op, instead of if/else
    end

    def turn
        puts "Please enter a number (1-9):"# ask for input
        user_input = gets.chomp # get input, gets.chomp gets a line, returns it, chomp removes a line break
        index = input_to_index(user_input) # translate input into index
        if valid_move?(index) # if index is valid
            # token = current_player
            move(index, current_player) # make the move for index
        else # else
            turn # ask for input again
        end
        display_board # show the board 
    end

    def won?
        WIN_COMBINATIONS.detect {|combination|(@board[combination[0]] == @board[combination[1]] && @board[combination[2]] == @board[combination[0]] && @board[combination[0]] != " ")}
        #  WIN_COMBINATIONS.each do |combination|
        #     if (@board[combination[0]] == @board[combination[1]] && @board[combination[2]] == @board[combination[0]] && @board[combination[0]] != " ")
        #         return combination
        #     end
        # end
        # nil
    end

    def full?
        @board.all? {|index| index != " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        !won? ? nil : @board[won?[0]]
        # WIN_COMBINATIONS.each do |combination|
        #     if (@board[combination[0]] == @board[combination[1]] && @board[combination[2]] == @board[combination[0]] && @board[combination[0]] != " ")
        #         return combination
        #     end
        # end
        # nil
    end

    def play
        display_board
        until over? do
            turn
        end 
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end