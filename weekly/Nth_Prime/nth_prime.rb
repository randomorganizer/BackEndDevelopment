require 'pry'
class Prime
  def self.nth(number)
    validate(number)
    primes = []
    counter = 2
    loop do
      primes << counter if self.is_prime?(counter)
      break if primes.size == number
      counter += 1
    end
    primes.last
  end

  private

  def self.is_prime?(number)
    (2...number).all? do |divisor|
      number % divisor != 0
    end
  end

  def validate(number)
    raise ArgumentError unless number > 0
  end
end