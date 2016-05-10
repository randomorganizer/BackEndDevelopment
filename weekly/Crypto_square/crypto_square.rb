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


=begin
  Solution Meeting Notes

  1 normalize the input
    gsub(/[^a-zA-Z0-9]/, '').downcase
  2 normalize characters broken into rows
  3 read down the column from left to right

  If square number then use that
  If it falls between numbers

  .size
    normalize_plaintext.size
    Math.sqrt(plain_text_size).ceil

  .plaintext_segements
    You could put the text together and then count columns and place a space
    You need to know what mehtods are available
    Normalize Plaintext
    Calculate size
    chars.each_slice(size).to_a.map(&:join) - good solution
    arr.group_by (not as good as above)
    arr.each_with_index.group_by (not as good as above)
    str.scan(/.{1,#{size}}/) - good solution also

  .ciphertext
    plaintext_segments
    array.map{*:chars}
    transpose method switches rows and columns, but sub arrrays must have same size
    So you would need to fill arrays with empty strings before transpose
    chars << '' if chars.size < size

    padded_segements = plaintext_segements.map do |string|
      string.size < size ? string + ' ' : string
    end
    padded_segwments.map(&:chars).trasnspose.map(&:join).map(&:strip).join

  Note in irb _ is the value of the previous return value




 
=end