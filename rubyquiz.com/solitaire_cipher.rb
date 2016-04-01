# Discard any non A to Z charcaters
# Uppercase all remaining letters.
#
# Split the message into five characeter groups using Xs to pad the last group if needed
#
# Use Soliatire to generate a keystream letter for each letter in the message.
#
# Convert the mesasge from step 1 into numbers, A=1, B=2 etc
#
# Convert the keystream letters from step 2 using the same method:
#
# Add the message numbers from step 3 to the keystream numbers from step 4
# Subtract 26 from result if it is greater than 26.
# For example, ^ + 10 = 16 as expected, but 26 + 1 = 1 (27-16)

# Convert the numbers back to letters

def initialize_deck
  deck = []
  (1..52).each {|num| deck.push(num) }
  deck << 'A' << 'B'
end

def encode(message)
  message = filter_characters(message)
  message = group_by_5(message)
  p keystream = solitaire_keystream
  # numericode message
  # numericode keystream
  # combine numericodes, sutract 26 if > 26
  # alphacode combination
end

def filter_characters(message)
  letters = message.upcase.chars
  letters.select { |letter| ('A'..'Z').include?(letter) }
end

def group_by_5(message)
  group_array = []
  size = (message.length % 5 == 0) ? message.length / 5 : (message.length / 5) + 1
  message.each_slice(size) { |a| group_array.push(a)}
  padright!(group_array[4], size, 'X')
end

def padright!(a, n, x)
  a.fill(x, a.length..n)
end

def solitaire_keystream
  deck = initialize_deck
  deck = switch_A_B(deck)
  deck = move_B_2(deck)
  deck = triple_cut(deck)
  deck = count_cut(deck)
  output_letter(deck)

  deck = switch_A_B(deck)
  deck = move_B_2(deck)
  deck = triple_cut(deck)
  deck = count_cut(deck)
  output_letter(deck)
end

def switch_A_B(deck)
  index_a = deck.index('A')
  index_b = deck.index('B')
  deck[index_a], deck[index_b] = deck[index_b], deck[index_a]
  deck
end

def move_B_2(deck)
  start_index = deck.index('B')
  end_index = start_index + 2
  end_index -= 53 if end_index > 53
  deck.delete_at(start_index)
  deck.insert(end_index, 'B')
end

def triple_cut(deck)
  index_a = deck.index('A')
  index_b = deck.index('B')
  stack1 = cut(deck, 'top', 'A') if index_a < index_b
  stack1 = cut(deck, 'top', 'B') if index_b < index_a
  stack2 = cut(deck, 'bottom', 'A') if index_a > index_b
  stack2 = cut(deck, 'bottom', 'B') if index_b > index_a
  deck.push(stack1).flatten!
  deck.unshift(stack2).flatten!
  deck
end

def cut(deck, side='top', card)
  index = deck.index(card)
  start = (side == 'top')? 0 : -1
  length = (side == 'top')? index : (deck.length - 1) - index
  stack = deck.slice!(start, length)
end

def count_cut(deck, side='bottom')
   #value = calculate_card_value(deck[-1])
   value = deck[-1]
   stack = deck.slice!(0, value)
   deck.insert(-2, stack).flatten!
end

def calculate_card_value(card)
  value = 0
  value = card if (1..13).include?(card)
  value = card - 13 if (14..26).include?(card)
  value = card - 26 if (27..39).include?(card)
  value = card - 39 if (40..52).include?(card)
  value
end

def output_letter(deck)
  number = deck[0]
  convert_to_letter(deck[number])
end

def convert_to_letter(number)
  number -= 1
  number = number / 2 if number > 25
  letters = ('A'..'Z').to_a
  letters[number]
end

def convert_to_number(letter)

end


message = 'Code in Ruby, live longer!'
encode(message)

# test_deck = [1,2,3,4,5]
# #stack1 = cut(test_deck, 'top', 2)
# stack2 = cut(test_deck, 'bottom', 5)

# #p test_deck.push(stack1).flatten!
# p test_deck.unshift(stack2).flatten!

#p convert_to_letter(5)

