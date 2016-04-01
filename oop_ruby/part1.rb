class Vehicle
  @@vehicle_count = 0

  def self.vehicle_count
    @@vehicle_count
  end
  def self.gas_mileage(gallons, miles)
    miles/gallons
  end
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@vehicle_count += 1
  end
  def speedup(number)
    @speed += number
    puts "You are now going #{@speed}"
  end
  def slowdown(number)
    @speed -= number
    puts "You are now going #{@speed}"
  end
  def stop
    @speed = 0
    puts "You are stopped"
  end
  def spraypaint(color)
    self.color = color
  end

  def to_s
    "This #{self.color} #{@model} was built in #{self.year}"
  end

  def age
    calculate_age
  end

  private
  def calculate_age
    now = Time.new
    "Years old: #{now.year - self.year}"
  end

end

module Towable
  def tow(pounds)
    if pounds < 1200
      puts 'Towed easily, beginning haul'
    else
      puts "That's too much to tow"
    end
  end
end

class MyTruck < Vehicle
  include Towable
  ENGINE = 'large'

end

class MyCar < Vehicle
  ENGINE = 'small'


end

sebring = MyCar.new(2003, 'chrysler sebring', 'gray')
sebring.speedup(20)
sebring.slowdown(5)
sebring.stop
puts sebring.color
sebring.spraypaint('silver')
puts sebring.color
puts sebring.year

puts sebring

puts MyCar.gas_mileage(5, 130)
puts Vehicle.vehicle_count

f150 = MyTruck.new(2007, 'Ford F150', 'blue')
f150.tow(1000)
puts Vehicle.vehicle_count

puts MyCar.ancestors, '---'
puts MyTruck.ancestors, '---'
puts Vehicle.ancestors


puts sebring.age
puts f150.age


class Student
  @name
  @grade
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  def name= name
    @name = name
  end
  def name
    @name
  end
  def grade= grade
    @grade = grade
  end
  def better_grade_than?(other_student)
    self.grade > other_student.grade
  end
  protected
  def grade
    @grade
  end
end

joe = Student.new("Joe", 85)
bob = Student.new('Bob', 82)

puts "Well done!" if joe.better_grade_than?(bob)
