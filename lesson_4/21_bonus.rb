require 'pry'

SUITS = %w(S C H D).freeze
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
POINT_GOAL = 21
DEALER_TARGET = 17

def prompt(text)
  puts '=> ' + text
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  values = cards.map { |card| card[1] }
  sum = 0
  values.each do |value|
    sum += 11 if value == 'A'
    sum += 10 if value.to_i == 0 && value != 'A'
    sum += value.to_i if value.to_i != 0
  end
  # correct for Aces
  correct_for_aces(values, sum)
end

def correct_for_aces(values, sum)
  values.count { |value| value == 'A' }.times do
    sum -= 10 if sum > POINT_GOAL
  end
  sum
end

def busted?(cards)
  total(cards) > POINT_GOAL
end

def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  return :player_busted if player_total > POINT_GOAL
  return :dealer_busted if dealer_total > POINT_GOAL
  return :player if dealer_total < player_total
  return :dealer if dealer_total > player_total
  :tie
end

def display_result(dealer_cards, player_cards, dealer_total, player_total)
  display_comparison(dealer_cards, player_cards, dealer_total, player_total)
  result = detect_result(dealer_cards, player_cards)
  prompt 'You busted! Dealer wins!' if result == :player_busted
  prompt 'Dealer busted! You win!' if result == :dealer_busted
  prompt 'You win!' if result == :player
  prompt 'Dealer wins!' if result == :dealer
  prompt "It's a tie" if result == :tie
  result
end

def display_comparison(dealer_cards, player_cards, dealer_total, player_total)
  # both palyer and dealer stays - compare cards!
  puts '============='
  prompt "Dealer has #{dealer_cards}, for a total of: #{dealer_total}"
  prompt "Player has #{player_cards}, for a total of: #{player_total}"
  puts '============='
end

def play_again?
  puts '------------'
  prompt 'Do you want to play again? (y or n)'
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def calculate_wins(player_wins, dealer_wins, game_result)
  player_wins[0] += 1 if game_result == :player || game_result == :dealer_busted
  dealer_wins[0] += 1 if game_result == :dealer || game_result == :player_busted
  declare_winner(player_wins, dealer_wins)
end

def declare_winner(player_wins, dealer_wins)
  if player_wins[0] == 5
    prompt('You won 5 games champ')
    player_wins[0] = 0
    dealer_wins[0] = 0
  end
  if dealer_wins[0] == 5
    prompt('Dealer won 5 games')
    player_wins[0] = 0
    dealer_wins[0] = 0
  end
end

player_wins = [0]
dealer_wins = [0]
loop do
  prompt 'Welcome to Twenty-One!'
  prompt 'Be the first to win 5 games'
  prompt "Player wins: #{player_wins[0]}"
  prompt "Dealer wins: #{dealer_wins[0]}"

  # initialize vars
  deck = initialize_deck
  player_cards = []
  dealer_cards = []
  player_total = 0
  dealer_total = 0

  # initial deal
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  prompt "Dealer has #{dealer_cards[0]} and ?"
  summary = "You have #{player_cards[0]} and #{player_cards[1]}," \
            "for a total of #{player_total}."
  prompt summary

  # player turn
  loop do
    player_turn = nil
    loop do
      prompt 'Would you like to (h)it or (s)tay?'
      player_turn = gets.chomp.downcase
      break if %w(h s).include?(player_turn)
      prompt "Sorry must enter 'h' or 's'."
    end

    if player_turn == 'h'
      player_cards << deck.pop
      player_total = total(player_cards)
      prompt 'You chose to hit!'
      prompt "Your cards are now: #{player_cards}"
      prompt "Your total is now: #{player_total}"
    end

    break if player_turn == 's' || busted?(player_cards)
  end

  if busted?(player_cards)
    game_result = display_result(dealer_cards, player_cards,
                                 dealer_total, player_total)
    calculate_wins(player_wins, dealer_wins, game_result)
    play_again? ? next : break
  else
    prompt "You stayed at #{player_total}"
    # game_result = display_result(dealer_cards, player_cards,
    #                            dealer_total, player_total)
    # calculate_wins(player_wins, dealer_wins, game_result)
  end

  # dealer turn
  prompt 'Dealer turn...'

  loop do
    break if busted?(dealer_cards) || dealer_total >= DEALER_TARGET
    prompt 'Dealer hits!'
    dealer_cards << deck.pop
    dealer_total = total(dealer_cards)
    prompt "Dealer's cards are now #{dealer_cards}"
  end

  if busted?(dealer_cards)
    prompt "Dealer total is now: #{dealer_total}"
    game_result = display_result(dealer_cards, player_cards,
                                 dealer_total, player_total)
    calculate_wins(player_wins, dealer_wins, game_result)
    play_again? ? next : break
  else
    prompt "Dealer stays at #{dealer_total}"
  end
  game_result = display_result(dealer_cards, player_cards,
                               dealer_total, player_total)
  calculate_wins(player_wins, dealer_wins, game_result)

  # here play again doesn't need next because it is at bottom of loop
  break unless play_again?
end
prompt 'Thank you for playing Twenty-One! Good bye!'
