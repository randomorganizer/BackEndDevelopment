class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @color = color
    @model = model
    @speed = 0
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
end

sebring = MyCar.new(2003, 'chrysler sebring', 'gray')
sebring.speedup(20)
sebring.slowdown(5)
sebring.stop
puts sebring.color
sebring.spraypaint('silver')
puts sebring.color
puts sebring.year
