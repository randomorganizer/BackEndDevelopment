# Crypto class takes a message and encodes it using square cipher
class Crypto
  def initialize(text)
    @text = text
    @normalization  # variable in void context offense rubocop?
    @segmentation   # variable in void context offense rubocop?
    @columns        # variable in void context offense rubocop?
    @rows           # variable in void context offense rubocop?
    @cipher         # variable in void context offense rubocop?
    encrypt
  end

  def normalize_plaintext
    @normalization
  end

  def plaintext_segments
    @segmentation
  end

  def ciphertext
    @cipher.join
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
    @columns = calculate_columns(@normalization)
    @rows = (@normalization.size / @columns.to_f).ceil
    @segmentation = segment(@normalization)
    @cipher = cipher
  end

  def calculate_columns(normalization)
    counter = 0
    loop do
      counter += 1
      break if (counter**2) >= normalization.size
    end
    counter
  end

  def normalize(text)
    text.scan(/\w+/).join.downcase
  end

  def segment(normalization)
    temp_text = normalization.clone
    (1..@rows).reduce([]) { |a, _e| a << temp_text.slice!(0, @columns) }
  end

  def cipher
    cipher_square = []
    @columns.times do |c|
      cipher_row = []
      @rows.times do |r|
        cipher_row << @segmentation[r].chars[c]
      end
      cipher_square << cipher_row.join
    end
    @cipher = cipher_square
  end
end
