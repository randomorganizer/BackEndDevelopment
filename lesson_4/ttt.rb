def start_program
  play_again = true
  while play_again
   play_game
   puts "Do you want to play again? Y/N"
   input = gets.chomp
   play_again = false unless input.chomp.downcase.include?('y')
  end
end

def play_game
  puts "Ready for some Tic Tac Toe\nSelect a space by choosing a number\nYou are Xs\nComputer is Os"
  game_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  winner = 'none'
  players_turn = true
  while winner == 'none'
    play_turn(players_turn, game_board)
    players_turn = !players_turn
    winner = determine_winner(game_board)
    winner = 'tie' if board_is_full?(game_board)
  end
  display_board(game_board)
  puts 'Congrat you win' if winner == 'Xs'
  puts 'Sorry, the computer won' if winner == 'Os'
  puts 'Its a tie' if winner == 'tie'
end

def play_turn(players_turn, game_board)
  player_takes_turn(game_board) if players_turn
  computer_takes_turn(game_board) if !players_turn
end

def player_takes_turn(game_board)
  display_board(game_board)
  valid = false
  while !valid
    puts 'Enter your number'
    selection = gets.chomp.to_i
    valid = valid_selection?(selection, game_board, false)
  end
  update_board(selection, 'X', game_board)
end

def computer_takes_turn(game_board)
  valid = false
  while !valid
    selection = get_computer_selection
    valid = valid_selection?(selection, game_board, true)
  end
  update_board(selection, 'O', game_board)
end

def get_computer_selection
  [1, 2, 3, 4, 5, 6, 7, 8, 9].sample
end

def valid_selection?(selection, game_board, suppress_message)
  valid_number?(selection, game_board, suppress_message) && 
    selection_available?(selection, game_board, suppress_message)
end

def valid_number?(selection, game_board, suppress_message)
  if (1..9).include?(selection)
    return true
  else
    puts 'Not a valid number' unless suppress_message
    return false
  end
end

def selection_available?(selection, game_board, suppress_message)
  index = get_board_index(selection)
  if(game_board[index[0]][index[1]] == selection)
    return true
  else
    puts 'That space is already taken' unless suppress_message
    return false
  end
end

def update_board(selection, icon, game_board)
  index = get_board_index(selection)
  game_board[index[0]][index[1]] = icon
end

def get_board_index(selection)
  index = []
  if selection < 4
    index << 0
    index << (selection - 1)
  elsif selection < 7
    index << 1
    index << (selection - 4)   
  elsif selection < 10
    index << 2
    index << (selection - 7)
  end
  index
end

def determine_winner(board)
  winner = horizontal_match?(board)
  return winner if winner != 'none'
  winner = vertical_match?(board)
  return winner if winner != 'none'
  return diagonal_match?(board)
end

def horizontal_match?(board)
  comma_sepearted_list = board[0].join + "," + board[1].join + "," + board[2].join
  three_in_a_row?(comma_sepearted_list)
end

def vertical_match?(board)
  comma_sepearted_list = ''
  3.times do |i|
    index = i -1
    comma_sepearted_list << board[0][index] << board[1][index] << board[2][index] << ","
  end
  three_in_a_row?(comma_sepearted_list)
end

def diagonal_match?(board)
  comma_sepearted_list = board[0][0].to_s + board[1][1].to_s + board[2][2].to_s
  comma_sepearted_list << "," << board[0][3].to_s << board[1][1].to_s << board[2][0].to_s
  three_in_a_row?(comma_sepearted_list)
end

def three_in_a_row?(comma_sepearted_list)
  return 'Xs' if comma_sepearted_list.include?('XXX')
  return 'Os' if comma_sepearted_list.include?('OOO')
  return 'none'
end

def board_is_full?(board)
  plays = board.flatten.uniq.join("")
  (plays.length < 3 )? true : false
end

def display_board(game_board)
  board = game_board
  display_text = ''
  display_text << ' #{board[0][0]} #{board[0][1]} #{board[0][2]}\n'
  display_text << ' #{board[1][0]} #{board[1][1]} #{board[1][2]}\n'
  display_text << ' #{board[2][0]} #{board[2][1]} #{board[2][2]}\n'
  puts display_text
end

start_program

# p get_board_index(1)
# p get_board_index(2)
# p get_board_index(3)
# p get_board_index(4)
# p get_board_index(5)
# p get_board_index(6)
# p get_board_index(7)
# p get_board_index(8)
# p get_board_index(9)
# p get_board_index(10)

# game_board = [ ["X","X","O"], ["O","X","O"], ["X","O","X"]]
# p board_is_full?(game_board)
