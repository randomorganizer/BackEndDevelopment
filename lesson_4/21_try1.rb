require 'pry'

def prompt(text)
  puts '=> ' + text
end

def display_screen(player_cards, dealer_cards)
  puts "Dealer:\n"
  prompt card_name(dealer_cards[0])
  puts "Player:\n"
  player_cards.each { |card| prompt(card_name(card)) }
  puts "\n"
end

def card_name(card)
  "#{card[:value]} of #{card[:suit]}"
end

def initialize_deck
  suits = %w(spades clubs hearts diamonds)
  values = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace']
  deck = []
  suits.each do |suit|
    values.each do |value|
      deck << { suit: suit, value: value }
    end
  end
  deck.sample(52)
end

def deal_card(deck, hand)
  hand << deck.shift
end

def opening_deal(deck, player_cards, dealer_cards)
  deal_card(deck, player_cards)
  deal_card(deck, dealer_cards)
  deal_card(deck, player_cards)
  deal_card(deck, dealer_cards)
end

def hand_busts?(hand)
  calculate_score(hand) > 21
end

def calculate_score(hand)
  total = 0
  hand.each do |card|
    total += card[:value] if card[:value].is_a? Numeric
    total += 10 if card[:value].to_s.length > 3
  end
  aces = count_aces(hand)
  total += determine_aces_value(total, aces)
end

def count_aces(hand)
  hand.count { |card| card[:value].to_s == 'ace' }
end

def determine_aces_value(total, aces)
  return 0 if aces == 0
  return aces if total > 10
  return 11 if aces == 1
  11 + (aces - 1)
end

# game loop
loop do
  player_cards = []
  dealer_cards = []
  player_score = 0
  dealer_score = 0

  # Initialize Deck
  deck = initialize_deck

  # Deal cards to player and dealer
  opening_deal(deck, player_cards, dealer_cards)

  # Display cards
  display_screen(player_cards, dealer_cards)

  # Player turn: hit or stay
  # repeat until bust or stay
  player_hand_busts = false
  # TODO: consider calculating score for 21 before this loop
  loop do
    prompt('Hit or Stay? (h/s)')
    answer = gets.chomp
    if answer.downcase.start_with?('h')
      deal_card(deck, player_cards)
      display_screen(player_cards, dealer_cards)
    end
    player_hand_busts = hand_busts?(player_cards)
    player_score = calculate_score(player_cards)
    break if answer.downcase.start_with?('s') || player_score >= 21
  end

  dealer_hand_busts = false
  # If player bust, dealer wins
  unless player_hand_busts
    # Dealer turn: hit or stay
    # repeat until total >= 17
    until dealer_score >= 17
      deal_card(deck, dealer_cards)
      dealer_score = calculate_score(dealer_cards)
    end
    # If dealer bust, player wins
    dealer_hand_busts = hand_busts?(dealer_cards)
  end

  # Compare cards and declare winner
  prompt("Player: #{player_score}\nDealer: #{dealer_score}\n")
  if player_hand_busts
    prompt('Dealer won, you busted')
  elsif dealer_hand_busts
    prompt('You won, dealer busted')
  elsif player_score == dealer_score
    prompt('It\'s a tie')
  else
    (player_score > dealer_score) ? prompt('You won') : prompt('Dealer won')
  end

  prompt 'Do you want to play another game? (y/n)'
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end
