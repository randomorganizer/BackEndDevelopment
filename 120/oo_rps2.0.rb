require 'pry'
class Shape
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze

  def self.make_shape(shape_name)
    return Rock.new if shape_name == 'rock'
    return Paper.new if shape_name == 'paper'
    return Scissors.new if shape_name == 'scissors'
    return Lizard.new if shape_name == 'lizard'
    return Spock.new if shape_name == 'spock'
  end

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Rock < Shape
  def initialize
    super('rock')
  end

  def >(other_shape)
    other_shape.class == Scissors ||
      other_shape.class == Lizard
  end

  def <(other_shape)
    other_shape.class == Paper ||
      other_shape.class == Spock
  end
end

class Scissors < Shape
  def initialize
    super('scissors')
  end

  def >(other_shape)
    other_shape.class == Paper ||
      other_shape.class == Lizard
  end

  def <(other_shape)
    other_shape.class == Rock ||
      other_shape.class == Spock
  end
end

class Paper < Shape
  def initialize
    super('paper')
  end

  def >(other_shape)
    other_shape.class == Rock ||
      other_shape.class == Spock
  end

  def <(other_shape)
    other_shape.class == Scissors ||
      other_shape.class == Lizard
  end
end

class Lizard < Shape
  def initialize
    super('lizard')
  end

  def >(other_shape)
    other_shape.class == Spock ||
      other_shape.class == Paper
  end

  def <(other_shape)
    other_shape.class == Rock ||
      other_shape.class == Scissors
  end
end

class Spock < Shape
  def initialize
    super('spock')
  end

  def >(other_shape)
    other_shape.class == Rock ||
      other_shape.class == Scissors
  end

  def <(other_shape)
    other_shape.class == Paper ||
      other_shape.class == Lizard
  end
end

class Player
  attr_accessor :shape, :name, :score, :moves, :result

  def initialize
    @score = 0
    @moves = []
  end
end

class Human < Player
  def initialize
    set_name
    super
  end

  def set_name
    n = nil
    loop do
      puts "What's your name"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Shape::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.shape = Shape.make_shape(choice)
  end
end

class Computer < Player
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].freeze

  def self.initialize_computer
    name = ROBOTS.sample
    return R2D2.new if name == 'R2D2'
    return Hal.new if name == 'Hal'
    return Chappie.new if name == 'Chappie'
    return Sonny.new if name == 'Sonny'
    return Number5.new if name == 'Number 5'
  end

  def choose
    choices = Shape::VALUES
    choices = logical_choices(choices) if RPSGame::AI_LOGIC
    choices = emotional_choices(choices) if RPSGame::AI_ATTITUDE
    self.shape = Shape.make_shape(choices.sample)
  end

  def logical_choices(choices)
    return choices if moves.count < 4
    winners = []
    Shape::VALUES.each do |shape|
      sum = moves.count do |move|
        move[0] == shape && move[1] == 'win'
      end
      winners << shape if sum >= 2
    end
    choices + (winners * 5)
  end
end

class R2D2 < Computer
  def initialize
    @name = 'R2D2'
    super
  end

  def emotional_choices(choices)
    choices.select { |element| element == 'rock' }
  end
end

class Hal < Computer
  def initialize
    @name = 'Hal'
    super
  end

  def emotional_choices(choices)
    choices = choices.select { |element| element != 'paper' }
    choices + (['scissors'] * moves.count)
  end
end

class Chappie < Computer
  def initialize
    @name = 'Chappie'
    super
  end

  def emotional_choices(choices)
    choices.select { |element| element != 'scissors' }
  end
end

class Sonny < Computer
  def initialize
    @name = 'Sonny'
    super
  end

  def emotional_choices(*)
    if moves.count.odd?
      ['rock', 'paper']
    else
      ['scissors', 'lizard']
    end
  end
end

class Number5 < Computer
  def initialize
    @name = 'Number 5'
    super
  end

  def emotional_choices(*)
    ['spock']
  end
end

class RPSGame
  AI_LOGIC = true
  AI_ATTITUDE = true

  attr_accessor :human, :computer, :winner

  def initialize
    @human = Human.new
    @computer = Computer.initialize_computer
    @winner = nil
  end

  def display_welcome_message
    puts "Welecome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.shape}"
    puts "#{computer.name} chose #{computer.shape}"
  end

  def display_winner
    round_winner = determine_winner
    log_history(round_winner)
    case round_winner
    when 'Human'
      puts "#{human.name} won!"
    when 'Computer'
      puts "#{computer.name} won!"
    when 'Tie'
      puts "It's a tie!"
    end
  end

  def display_history
    puts 'Here is what happened'
    moves = human.moves.length
    (0...moves).each do |n|
      puts "You played #{human.moves[n][0]} & Computer played #{computer.moves[n][0]}"
    end
  end

  def determine_winner
    if human.shape > computer.shape
      human.score += 1
      "Human"
    elsif human.shape < computer.shape
      computer.score += 1
      "Computer"
    else
      "Tie"
    end
  end

  def game_winner?
    winner != nil
  end

  def declare_game_winner
    if human.score == 10
      self.winner = human.name
    elsif computer.score == 10
      self.winner = 'Computer'
    end
  end

  def log_history(round_winner)
    log_tie if round_winner == 'Tie'
    log_human_winner if round_winner == 'Human'
    log_computer_winner if round_winner == 'Computer'
  end

  def log_tie
    human.moves.push([human.shape.to_s, 'tie'])
    computer.moves.push([computer.shape.to_s, 'tie'])
  end

  def log_human_winner
    human.moves.push([human.shape.to_s, 'win'])
    computer.moves.push([computer.shape.to_s, 'lose'])
  end

  def log_computer_winner
    human.moves.push([human.shape.to_s, 'lose'])
    computer.moves.push([computer.shape.to_s, 'win'])
  end

  def display_score
    puts "***Player #{human.score} Computer #{computer.score}***"
    display_game_winner if !winner.nil?
  end

  def display_game_winner
    puts "#{winner} wins the game!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, you must be y or n."
    end
    return false if answer.casecmp('n') == 0
    if answer.casecmp('y') == 0
      reset_game
      return true
    end
  end

  def reset_game
    initialize
  end

  def play
    display_welcome_message
    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        declare_game_winner
        display_score
        break if game_winner?
      end
      display_history
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
