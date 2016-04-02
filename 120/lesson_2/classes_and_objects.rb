# Exercise 1
class Person
  attr_accessor :name
  def initialize name
    self.name = name
  end
end

bob = Person.new('bob')
p bob.name
bob.name = 'Robert'
p bob.name


# Exercise 2
class Person2
  attr_accessor :first_name, :last_name
  def initialize name
    self.first_name = name
  end
  def name
    "#{first_name} #{last_name}".strip
  end
end

bob2 = Person2.new('Bob')
p bob2.name
p bob2.first_name
p bob2.last_name
bob2.last_name = 'Smith'
p bob2.name

# Exercise 3 & 5
class Person3
  attr_accessor :first_name, :last_name
  def initialize name
    self.first_name = name
  end
  def name
    "#{first_name} #{last_name}".strip
  end
  def name=(name)
    names = name.split(' ')
    self.first_name = names[0].strip
    self.last_name = names[1].strip
  end
  def to_s
    name
  end
end

bob3 = Person3.new('Bob')
p bob3.name = "John Adams"
p bob3.first_name
p bob3.last_name

# Exercise 4
bob4 = Person3.new('Robert Smith')
rob4 = Person3.new('Robert Smith')

bob4.name == rob4.name


# Exercise 5
puts "The person's name is: #{bob4}"



