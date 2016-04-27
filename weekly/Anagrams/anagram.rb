class Anagram
  def initialize(word)
    @word = word
    @list = []
    @anagrams = []
  end

  def match(list)
    @list = list
    sorted_word = @word.downcase.chars.sort
    sorted_list = []
    list.each do |word|
      next if word.downcase == @word.downcase
      sorted_list.push(word) if sorted_word == word.downcase.chars.sort
    end
    sorted_list
  end

end