# Trinary takes a number in string format and converts it to decimal
class Trinary
  def initialize(number)
    @number = number
  end

  def to_decimal
    total = 0
    @number.reverse.chars.each_with_index do |obj, idx|
      total += obj.to_i * 3**idx
    end if @number =~ /^[0-9]*$/
    total
  end
end
