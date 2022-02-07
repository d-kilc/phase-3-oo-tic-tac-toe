require 'pry'
class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        puts "#{self.board[0]}|#{self.board[1]}|#{self.board[2]}"
        puts "-----------"
        puts "#{self.board[3]}|#{self.board[4]}|#{self.board[5]}"
        puts "-----------"
        puts "#{self.board[6]}|#{self.board[7]}|#{self.board[8]}"
    end

    def input_to_index input
        input.to_i - 1
    end
        
    def move index, token="X"
        self.board[index] = token
    end

    def position_taken? index
        self.board[index] != " "
    end

    def valid_move? index
        !self.position_taken?(index) && (index >=0 && index <= 8)
    end

    def turn_count
        self.board.count{|x| x != " "}
    end

    def current_player
        self.turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "#{self.current_player}, which square? (1-9)"
        input = gets
        index = self.input_to_index input

        if self.valid_move? index
            self.move index, self.current_player
            puts "Board: "
            self.display_board
        else
            puts "Sorry, that square's taken."
            self.turn
        end
    end

    def won?
        result_array = WIN_COMBINATIONS.map do |n|
            # self.board[n[0]] == self.board[n[1]] && self.board[n[0]] == self.board[n[2]] && self.board[n[1]] == self.board[n[2]]
            sq_one = self.board[n[0]]
            sq_two = self.board[n[1]]
            sq_three = self.board[n[2]]
            sq_one == sq_two && sq_two == sq_three && sq_one == sq_three && sq_one != " "
        end
        result_array.include? true
    end

    def full?
        self.board.count{|n| n != " "} == 9
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.won? || self.full?
    end

    def winner
        result_array = WIN_COMBINATIONS.map do |n|
            if self.board[n[0]] == "X" && self.board[n[1]] == "X" && self.board[n[2]] == "X"
                "X"
            elsif self.board[n[0]] == "O" && self.board[n[1]] == "O" && self.board[n[2]] == "O"
                "O"
            end
        end

        if result_array.include? "X"
            "X"
        elsif result_array.include? "O"
            "O"
        end
    end

    def play
        until self.over? do
            self.turn
        end

        if self.draw?
            puts "Cat's Game!"
        end

        puts "Congratulations #{self.winner}!"
        self.winner
    end
    # binding.pry
end