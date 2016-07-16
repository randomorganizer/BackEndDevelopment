family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
#immediatefamily = family.select { |k,v| k==:sisters || k==:brothers}.to_a #not quite right
immediatefamily = family.select { |k,v| k==:sisters || k==:brothers}.values.flatten
p immediatefamily.to_s



vegetable1 = {pea1: "bert", origin: "pod"}
vegetable2 = {pea2: "ernie", origin: "pod"}

simile = vegetable1.merge(vegetable2)
p simile


statusquo = {computing: "abacus", research: "word of mouth"}
internet = {computing: "microprocessor", research: "watson"}

statusquo.merge!(internet)
p statusquo


breakfast = {entree: "ham", side: "hashbrowns", bread: "biscuit"}

def printkeys(hash)
  hash.each {|k,v| p k}
end

def printvalues(hash)
  hash.each {|k,v| p v}
end

def printhash(hash)
  printkeys(hash)
  printvalues(hash)
end

printhash(breakfast)


person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
puts person[:name]

cardrequest = 'pike'
cards = {card1:"salmon", card2: "pike", card3: "catfish"}
if(cards.has_value?(cardrequest))
  puts "Take your #{cardrequest}"
else
  puts "Go fish"  
end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
anagrams = {}
words.each do |word|
  #got stuck and found this part on SO http://stackoverflow.com/questions/15855480/how-to-sort-array-of-words-into-arrays-of-anagrams-in-ruby
  anagrams[word.split('').sort.join] ||=[]
  #sort all the letters in the word alphabetically
  #if the alphabetized 'key' exits, move along, else initialize the value with array
  
  anagrams[word.split('').sort.join] << word
  #insert the word into the array

end
p anagrams.values
