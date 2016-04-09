require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonals

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  # rubocop: disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+------"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def computer_moves(player_marker, computer_marker)
    square = nil
    Board::WINNING_LINES.each do |line|
      square = find_at_risk_square(line, computer_marker)
      break if square
    end
    if !square
      Board::WINNING_LINES.each do |line|
        square = find_at_risk_square(line, player_marker)
        break if square
      end
    end
    if !square
      square = 5 if @squares[5].unmarked?
      square ||= unmarked_keys.sample
    end
    self[square] = computer_marker
  end


  def find_at_risk_square(line, marker)
    if @squares.values_at(*line).count { |square| square.marker == marker } == 2 &&
      @squares.values_at(*line).any? { |square| square.marker == Square::INITIAL_MARKER }
      @squares.select { |k,v| line.include?(k) && v.marker == Square::INITIAL_MARKER}.keys.first
    end
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " ".freeze
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score, :name

  def initialize(marker)
    @marker = marker
    @score = 0
  end

  def marker=(value)
    @marker = value.upcase if ('A'..'Z').include?(value.upcase)
  end
end

class TTTGame
  HUMAN_MARKER = 'X'.freeze
  COMPUTER_MARKER = 'O'.freeze
  FIRST_TO_MOVE = HUMAN_MARKER
  attr_reader :board, :human, :computer
  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @computer.name = ['Bill', 'Bob', 'Ben'].sample
    @current_marker = FIRST_TO_MOVE
  end

  def play
    loop do
      setup_game
      loop do
        display_board
        loop do
          current_player_moves
          break if someone_won? || board.full?
          clear_screen_and_display_board if human_turn?
        end
        display_result
        break if five_game_winner?
        break unless play_again? 
        reset
        display_play_again_message
      end
      display_five_game_winner if five_game_winner?
      break unless play_another_set?
    end
    display_goodbye_message
  end

  private

  def setup_game
    reset
    display_welcome_message
    player_enters_name
    player_picks_marker
    clear
  end

  def someone_won?
    !!calculate_winner
  end

  def calculate_winner
    winner = board.winning_marker
    human.score = human.score.to_i + 1 if human.marker == winner
    computer.score += 1 if computer.marker == winner
    winner
  end

  def player_enters_name
    response = nil
    loop do
      puts 'Enter your name'
      response = gets.chomp
      break unless response.empty?
      puts 'Must enter a name'
    end
    human.name = response
  end

  def player_picks_marker
    response = nil
    loop do
      puts 'Enter the marker you want to use (A-Z)'
      response = gets.chomp.upcase
      break if ('A'..'Z').include?(response) 
      puts 'Must select A-Z'
    end
    human.marker = response
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts
  end

  def display_goodbye_message
    puts 'Thanks for playing tick Tac Toe! Goodbye!'
  end

  def display_five_game_winner
    puts "#{human.name} won 5 games" if human.score >= 5
    puts "#{computer.name} won 5 games" if computer.score >= 5
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    display_score
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square between (#{joinor(board.unmarked_keys)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end
    board[square] = human.marker
  end

  def joinor(list, delimiter=', ', conjunction='or')
    list[-1] = "#{conjunction} #{list.last}" if list.size > 1
    list.join(delimiter)
  end

  def computer_moves
    # board[board.unmarked_keys.sample] = computer.marker
    board.computer_moves(human.marker, computer.marker)
  end



  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "The board is full"
    end
  end

  def display_score
    puts "#{human.name} has #{human.score} and #{computer.name} has #{computer.score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Ready to play another round? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be a y or n"
    end
    answer == 'y'
  end

  def play_another_set?
    response = nil
    loop do
      puts "Want to play a new set of 5? (y/n)"
      response = gets.chomp
      break if %w(y n).include? response.downcase
      puts "Sorry must select y or n"
    end
    response == 'y'
  end

  def five_game_winner?
    human.score >= 5 || computer.score >= 5
  end

  def reset
    board.reset
    clear
    @current_marker = FIRST_TO_MOVE
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def clear
    system 'clear'
  end
end

game = TTTGame.new
game.play
