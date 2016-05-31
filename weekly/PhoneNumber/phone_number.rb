# Phone class formats text for sms
class PhoneNumber
  attr_reader :area_code

  def initialize(text)
    @area_code = '000'
    @number = '0000000'
    digits = parse_text(text)
    parse_digits(digits) if valid?(digits)
    self
  end

  def number
    @area_code + @number
  end

  def to_s
    "(#{@area_code}) #{@number.insert(3, '-')}"
  end

  private

  def parse_text(text)
    text.scan(/\d+|[a-zA-Z]/).join
  end

  def valid?(digits)
    return false unless /^\d+$/ === digits
    return true if digits.length == 10
    return true if digits.length == 11 && digits[0] == '1'
    false
  end

  def parse_digits(digits)
    digits.slice!(0) if digits.length == 11 && digits[0] == '1'
    @area_code = digits[0, 3]
    @number = digits[3, 9]
  end
end
