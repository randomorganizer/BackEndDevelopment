require 'pry'
class Shape
  VALUES = ['rock', 'paper', 'scissors'].freeze

  def self.make_shape(shape_name)
    return Rock.new if shape_name == 'rock'
    return Paper.new if shape_name == 'paper'
    return Scissors.new if shape_name == 'scissors'
  end

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

end

class Rock < Shape
  def initialize
    super('rock')
  end
  def >(other_shape)
    other_shape.class == Scissors
  end
  def <(other_shape)
    other_shape.class == Paper
  end
end

class Scissors < Shape
  def initialize
    super('scissors')
  end
  def >(other_shape)
    other_shape.class == Paper
  end
  def <(other_shape)
    other_shape.class == Rock
  end
end

class Paper < Shape
  def initialize
    super('paper')
  end
  def >(other_shape)
    other_shape.class == Rock
  end
  def <(other_shape)
    other_shape.class == Scissors
  end
end

class Player
  attr_accessor :shape, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
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
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Shape::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.shape = Shape.make_shape(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.shape = Shape.make_shape(Shape::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer, :winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    @winner = nil
  end

  def display_welcome_message
    puts "Welecome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.shape}"
    puts "#{computer.name} chose #{computer.shape}"
  end

  def display_winner
    case determine_winner
    when 'Human'
      puts "#{human.name} won!"
    when 'Computer'
      puts "#{computer.name} won!"
    when 'Tie'
      puts "It's a tie!"
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
      #binding.pry
      self.winner = human.name
    elsif computer.score == 10
      self.winner = 'Computer'
    end 
  end

  def display_score
    puts "***Player #{human.score} Computer #{computer.score}***"
    display_game_winner if self.winner != nil
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
    return true if answer.casecmp('y') == 0
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
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
