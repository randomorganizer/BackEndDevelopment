# Phrase takes a phrase and counts the word occurrences
class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    phrase = @phrase.downcase
    words = split_phrase(phrase)
    words = words.map { |word| filter_punctuation(word) }
    to_word_count_hash(words)
  end

  def filter_punctuation(word)
    # http://stackoverflow.com/questions/3453262/how-to-strip-leading-and-trailing-quote-from-string-in-ruby
    word = word.chomp("'").reverse.chomp("'").reverse
    word = word.chars.select do |char|
      ('a'..'z').cover?(char) || char.to_i.to_s == char || "'" == char
    end
    (word.count == 0) ? nil : word.join
  end

  def split_phrase(phrase)
    phrase.split.map do |word|
      word.split(',').map do |item|
        item.split('\n')
      end
    end.flatten
  end

  def to_word_count_hash(words)
    words.each_with_object({}) do |acc, obj|
      acc[obj].nil? ? acc[obj] = 1 : acc[obj] += 1 unless obj.nil?
    end
  end
end
