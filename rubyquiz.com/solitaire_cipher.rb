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
  p message = solitaire_keystream
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

message = 'The Robin flies at dawn'
encode(message)
