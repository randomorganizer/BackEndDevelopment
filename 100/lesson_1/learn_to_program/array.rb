puts 'type in as many words as you want, 1 per line, i dare you'

words = []

input = gets.chomp
while input.length > 0
  words.push(input)
  input = gets.chomp
end

#puts words.sort

puts 'now to sort them'


sorted_words = []
words.each do |word|
  if sorted_words.length == 0
    sorted_words << word
  else
    sorted_words.each do |sorted_word|
      if sorted_word.downcase < word
        sorted_words.push(word)
        break
      else
        sorted_words.unshift(word)
        break
      end
    end
  end
end
p sorted_words

lineWidth = 50
toc = [['Chapter 1: Numbers', 'page 1'], ['Chapter 2: Lettesr', 'page 72'], ['Chapter 3: Variables', 'page 118']]
puts 'Table of Contents'.center lineWidth
toc.each do |line|
  puts line[0].ljust(lineWidth/2) + line[1].rjust(lineWidth/2)
end

