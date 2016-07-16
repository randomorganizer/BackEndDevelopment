# require_relative 'english_number'

class Integer
  def to_eng
    if self == 5
      english = 'five'
    else
      english = 'fifty-eight'
    end

    english
  end
end

  # I'd better test on a couple of numbers...
puts 5.to_eng
puts 58.to_eng

class OrangeTree
  def initialize
    @height = 10
    @age = 1
    @oranges = 0
  end
  def height
    @height
  end
  def oranges
    @oranges
  end

  def oneYearPasses
    orangesFallOff
    treeGrows
    treeProducesFruit
    treeAges
  end
  def pickAnOrange
    @oranges -= 1
    eatOrange
  end


  private

  def treeGrows
    @height += 1
  end
  def treeAges
    @age += 1
    if @age > 10
      puts 'tree dies'
      exit
    end
  end
  def treeProducesFruit
    if @age > 2
      @oranges += 10
    elsif @age > 5
      @oranges += 15
    elsif @age > 7
      @oranges += 20
    end
  end
  def eatOrange
    if @oranges % 4 == 0
      puts 'It tastes sour'
    elsif @oranges % 3 == 0
      puts 'It tastes great'
    else
      puts 'It tastes ok'
    end
  end
  def orangesFallOff
    @oranges = 0
  end
end

mandarin = OrangeTree.new
mandarin.oneYearPasses
p mandarin.height
mandarin.oneYearPasses
p mandarin.height
mandarin.oneYearPasses
mandarin.oneYearPasses
mandarin.pickAnOrange
mandarin.oneYearPasses
mandarin.oneYearPasses
mandarin.pickAnOrange