require 'pry'
class Crypto
  def initialize(text)
    @text = text
    @normalization
    @segmentation
    @columns
    @rows
    @cipher
    encrypt
    #binding.pry
  end

  def normalize_plaintext
    @normalization
  end

  def plaintext_segments
    @segmentation
  end

  def ciphertext
    @cipher.join.gsub(' ','')
  end

  def normalize_ciphertext
    @cipher.join(' ')
  end

  def size
    @columns
  end

  private

  def encrypt
    @normalization = normalize(@text)
    #@columns = Math.sqrt(@normalization.size).ceil
    @columns = calculate_columns(@normalization)
    @rows = (@normalization.size / @columns.to_f).ceil
    @segmentation = segment(@normalization)
    @cipher = cipher
  end

  def calculate_columns(text)
    counter = 0
    loop do
      counter += 1
      break if (counter ** 2) >= text.size 
    end
    counter
  end

  def normalize(text)
    text.scan(/\w+/).join.downcase
  end

  def segment(text)
    temp_text = text.clone
    (1..@rows).reduce([]) { |acc,_| acc << temp_text.slice!(0, @columns)}
  end

  def cipher
    cipher_square = []
    @columns.times do |c|
      cipher_row = []
      @rows.times do |r|
        #binding.pry
        cipher_row << @segmentation[r].chars[c]
      end
      cipher_square << (cipher_row.join)
    end
    @cipher = cipher_square
  end

end