require 'pry'
INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
PLAYS_FIRST = 'Player'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[2, 5, 8], [1, 4, 7], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
# I realized this array does not have all needed values
# I will leave it be since i am going with the given solution
DEFENSIVE_LINES = [[1, 2, 3], [2, 3, 1], [4, 5, 6], [5, 6, 4]] +
                  [[7, 8, 9], [8, 9, 7], [1, 4, 7], [4, 7, 1]] +
                  [[2, 5, 8], [5, 8, 2], [3, 6, 9], [6, 9, 3]] +
                  [[1, 5, 9], [5, 9, 1], [3, 5, 7], [5, 7, 3]]
def prompt(msg)
  puts '=> ' + msg
end

# rubocop: disable Metrics/MethodLength, Metrics/AbcSize
def display_board(board, scores)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is an #{COMPUTER_MARKER}"
  puts display_scores(scores)
  puts ''
  puts '     |     |'
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts '     |     |'
  puts ''
end
# rubocop: enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt 'Sorry that is not a valid entry'
  end
  brd[square] = PLAYER_MARKER
end

def joinor(array, delimiter = ', ', conjunction = 'or')
  # my solution
  # temp_array = array
  # last_item = temp_array.pop
  # temp_array.join(delimiter) + ', ' + conjunction + ' ' + last_item.to_s
  array[-1] = "#{conjunction} #{array.last}" if array.size > 1
  array.join(delimiter)
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square
    squares = empty_squares(brd)
    square = 5 if squares.include?(5)
    square ||= squares.sample
  end

  brd[square] = COMPUTER_MARKER
end

# given solution
def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

# my solution 
def defensive_space(brd)
  DEFENSIVE_LINES.each do |line|
    return line[2] if (brd.values_at(line[0], line[1]).count(PLAYER_MARKER) == 2) && brd[line[2]] == ' '
  end
  nil
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  detect_winner(brd).nil? ? false : true
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def won_5_games?(scores)
  scores.select { |k,v| v == 5}
end

def display_scores(scores)
  score = ''
  scores.each { |k,v| score += "#{k}: #{v}\n" }
  score
end

def place_piece!(brd, current_player)
  player_places_piece!(brd) if current_player == 'Player'
  computer_places_piece!(brd) if current_player == 'Computer'
end

def alternate_player(current_player)
  return 'Computer' if current_player == 'Player'
  return 'Player' if current_player == 'Computer'
end

loop do
  scores = {'Player' => 0, 'Computer' => 0}
  interrupt_play = false
  loop do
    board = initialize_board
    current_player = PLAYS_FIRST
    loop do
      display_board(board, scores)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, scores)

    if someone_won?(board)
      winner = detect_winner(board)
      scores[winner] += 1
      prompt "#{winner} won!"
    else
      prompt 'It\'s a tie'
    end

    won_5_games = won_5_games?(scores)
    if won_5_games.empty?
      prompt 'Ready for the next round? (y/n)'
      answer = gets.chomp.downcase
      unless answer.start_with?('y')
        interrupt_play = true
        break
      end
    else
      prompt "#{won_5_games.key(5)} won 5 rounds!}"
      break
    end
  end
  break if interrupt_play == true
  prompt 'Play another game? (y or n)'
  answer = gets.chomp.downcase
  break unless answer.downcase.start_with?('y')
end

prompt('Thanks for playing Tic Tac Toe! Good-bye!')
