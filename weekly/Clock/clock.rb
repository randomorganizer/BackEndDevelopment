# Clock creates a time object without date
class Clock
  def initialize(hours, minutes)
    @hours = hours
    @minutes = minutes
  end

  def self.at(hours, minutes = 0)
    Clock.new(hours, minutes)
  end

  def +(other)
    @minutes += other
    round_minutes
    round_midnight
    self
  end

  def -(other)
    @minutes -= other
    round_minutes
    round_midnight
    self
  end

  def ==(other)
    to_s == other.to_s
  end

  def to_s
    "#{format(@hours)}:#{format(@minutes)}"
  end

  def format(number)
    number.to_s.rjust(2, '0')
  end

  def round_minutes
    @hours += @minutes / 60 if @minutes > 0
    @hours += (@minutes / 60.0).round if @minutes < 0
    @minutes = (@minutes % 60).abs
  end

  def round_midnight
    @hours = @hours % 24
  end
end
