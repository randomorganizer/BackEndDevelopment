VALID_CHOICES = %w(rock paper scissors).freeze

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    return "Computer won!"
  else
    return "It's a tie"
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    break if VALID_CHOICES.include?(choice)
    prompt("That's not a valid choice")
  end

  computer_choice = VALID_CHOICES.sample()
  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  prompt(display_results(choice, computer_choice))

  prompt("Do you want to play again? Y/N")
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end
prompt("Thank you for playing Good-bye")
