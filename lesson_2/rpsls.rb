VALID_CHOICES = %w(rock paper scissors lizard Spock).freeze

def prompt(message)
  Kernel.puts("=> #{message}")
end

def rock_wins?(first, second)
  (first == 'r' && second == 'l') ||
    (first == 'r' && second == 's')
end

def paper_wins?(first, second)
  (first == 'p' && second == 'r') ||
    (first == 'p' && second == 'S')
end

def scissors_wins?(first, second)
  (first == 's' && second == 'p') ||
    (first == 's' && second == 'l')
end

def lizard_wins?(first, second)
  (first == 'l' && second == 'S') ||
    (first == 'l' && second == 'p')
end

def spock_wins?(first, second)
  (first == 'S' && second == 's') ||
    (first == 'S' && second == 'r')
end

def win?(first, second)
  first = first.chars.first
  second = second.chars.first
  rock_wins?(first, second) ||
    paper_wins?(first, second) ||
    scissors_wins?(first, second) ||
    lizard_wins?(first, second) ||
    spock_wins?(first, second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt "You won that round!"
    return "player"
  elsif win?(computer, player)
    prompt "Computer won that round!"
    return "computer"
  else
    prompt "It's a tie"
    return "tie"
  end
end

def choice_is_valid?(user_choice)
  VALID_CHOICES.any? do |valid_choice|
    valid_choice == user_choice ||
      valid_choice.chars.first == user_choice.chars.first
  end
end

loop do # game loop
  player_score = 0
  computer_score = 0
  loop do # round loop
    choice = ''
    loop do # choice loop
      prompt("Choose one: #{VALID_CHOICES.join(', ')}\nFirst to 5 wins!")
      choice = Kernel.gets().chomp()

      break if choice_is_valid?(choice)
      prompt("That's not a valid choice")
    end

    computer_choice = VALID_CHOICES.sample()
    Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

    winner = display_results(choice, computer_choice)
    if winner == "player"
      player_score += 1
    elsif winner == "computer"
      computer_score += 1
    end

    prompt("The score is player #{player_score} and computer #{computer_score}")

    if player_score == 5
      prompt("You scored 5 points and won the game")
      break
    elsif computer_score == 5
      prompt("The computer scored 5 points and won the game")
      break
    end
  end

  prompt("Do you want to play again? Y/N")
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt("Thank you for playing Good-bye")
