# Lecture - 1

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim 

rocko = Bulldog.new
puts rocko.swim

# Lecture - 2
class Pet2
  def speak
    'bark!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end


end

class Dog2 < Pet2
  def fetch
    'fetching!'
  end
  def swim
    'swimming!'
  end
end

class Cat2 < Pet2
  def speak
    'meow'
  end
end

# Lecture - 3
# Pet
#  |  \
# Dog Cat
#  |
# Bulldog

# Lecture - 4
# the object heirarchy and the order in which they are inspected for the called method, very important, it tells you what object will execute the called method
