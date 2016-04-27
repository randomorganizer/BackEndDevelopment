class Anagram

  attr_reader :word, :letters

  def initialize(word)
    @word = word
  end

  def match(list)
    list.select { |word_in_list| sortless_anagram? @word, word_in_list }
  end

  private

  def anagram? word1, word2
    return false if word1.downcase == word2.downcase
    word1.downcase.chars.sort == word2.downcase.chars.sort
  end

  def sortless_anagram? word1, word2
    return false if word1.downcase == word2.downcase
    word2_letters = word2.downcase.chars
    word1.downcase.chars.each do |letter|
      return false unless word2_letters.include?(letter)
      word2_letters.delete_at(word2_letters.index(letter))
    end
    word2_letters.length == 0
  end

end