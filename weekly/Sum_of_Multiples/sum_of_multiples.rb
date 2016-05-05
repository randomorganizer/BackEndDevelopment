require 'pry'
class SumOfMultiples
  DEFAULT_DIVISORS = [3,5]
  def initialize(*divisors)
    @divisors = divisors
  end

  def self.to(number, divisors=DEFAULT_DIVISORS)
    sum_multiples(select_multiples(number, divisors))
  end

  def to(number)
    SumOfMultiples.to(number, @divisors)
  end

  private

  def self.select_multiples(high_number, divisors)
    (1...high_number).select { |n| divisors.any? { |d| n % d == 0 } }
  end

  def self.sum_multiples(multiples)
    multiples.inject(0) { |sum,n| sum + n }
  end

end