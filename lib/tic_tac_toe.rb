class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ].freeze

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    rows = @board.each_slice(3).to_a
    rows.each_with_index do |row, index|
      puts " #{row[0]} | #{row[1]} | #{row[2]} "
      puts "-----------" unless index == 2
    end
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, player_token)
    @board[index] = player_token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.count { |position| position != " " }
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Please enter a number (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      puts "Invalid move. Please try again."
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      positions = [@board[win_combination[0]], @board[win_combination[1]], @board[win_combination[2]]]
      return win_combination if positions.all?("X") || positions.all?("O")
    end
    false
  end

  def full?
    @board.all? { |position| position != " " }
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

def winner
  if win_combination = won?
    @board[win_combination[0]]
  end
end

  def play
    display_board

    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end