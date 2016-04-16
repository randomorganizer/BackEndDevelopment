require 'pry'
module Participant
  def initialize
    @cards = []
  end

  def deal(deck)
    @cards.push(deck.deal)
    @cards.push(deck.deal)
  end

  def hit(deck)
    card = deck.deal
    @cards.push(card)
    card
  end

  def busted?
    total > 21
  end

  def total
    total = 0
    @cards.each { |card| total += card.value }
    calculate_aces_bonus(total)
  end

  private

  def calculate_aces_bonus(base_total)
    @cards.select { |ace| ace.face == 'Ace' }.each { base_total += 10 if base_total <= 11 }
    base_total
  end
end

class Player
  include Participant

  def initialize
    super()
  end

  def cards_showing
    "#{@cards[0].face} of #{@cards[0].suit} and #{@cards[1].face} of #{@cards[1].suit}"
  end

  def hit?
    puts "Would you like to hit (h) or stay (s)?"
    response = nil
    loop do
      response = gets.chomp.downcase
      break if %w(h s).include?(response)
      puts "Must select 'h' or 's'"
    end
    response == 'h'
  end
end

class Dealer
  include Participant

  def initialize
    super()
  end

  def cards_showing
    "#{@cards[0].face} of #{@cards[0].suit}"
  end

  def display_cards
    "Dealer drew " + @cards.map { |card| card.face + " of " + card.suit }.join(', ')
  end

  def hit?
    total < 18
  end
end

class Deck
  SUITS = %w(Spades Clubs Hearts Diamonds).freeze
  VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).freeze

  def initialize
    @cards = []
    SUITS.product(VALUES).each do |card|
      @cards.push(Card.new(card[0], card[1], base_value(card[1])))
    end
    @cards.shuffle!
  end

  def deal
    @cards.pop
  end

  private

  def base_value(face)
    return face.to_i if %w(2 3 4 5 6 7 8 9 10).include?(face)
    return 10 if %w(Jack Queen King).include?(face)
    return 1 if face == 'Ace'
  end
end

class Card
  attr_reader :suit, :face, :value
  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end
end

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn unless @player.busted?
    show_result
  end

  private

  def deal_cards
    @player.deal(@deck)
    @dealer.deal(@deck)
  end

  def show_initial_cards
    puts "Dealer has #{@dealer.cards_showing}"
    puts "You have #{@player.cards_showing} for a total of #{@player.total}"
  end

  def player_turn
    loop do
      break unless @player.hit?
      card = @player.hit(@deck)
      display_card(card)
      break if @player.busted?
    end
  end

  def display_card(card)
    puts "You drew #{card.face} of #{card.suit} for a total of #{@player.total}"
  end

  def player_break
  end

  def dealer_turn
    while @dealer.hit?
      @dealer.hit(@deck)
    end
  end

  def show_result
    puts @dealer.display_cards
    puts "Player score: #{@player.total} Dealer score: #{@dealer.total}"
    display_winner
  end

  def display_winner
    if @player.busted?
      puts 'You busted. Dealer wins'
    elsif @dealer.busted?
      puts 'Dealer busted. You win'
    elsif @player.total > @dealer.total
      puts 'You win'
    elsif @dealer.total > @player.total
      puts 'Dealer wins'
    elsif @player.total == @dealer.total
      puts 'Tie'
    end
  end
end

Game.new.start
