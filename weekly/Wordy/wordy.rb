# WordProblem calculates math problems given in natural language
class WordProblem
  def initialize(question)
    @question = question
    @values = []
    @operations = []
  end

  def answer
    parse_question
    validate_question
    calculate
  end

  private

  def validate_question
    raise ArgumentError, 'No valid values stated' if @values.count == 0
    raise ArgumentError, 'Must provide more than 1 number' if @values.count == 1
    raise ArgumentError, 'Must specify operation' if @operations.count == 0
  end

  def parse_question
    @question.slice!('?')
    words = @question.split(' ')
    words.each do |word|
      @values.push(word.to_i) if integer?(word)
      @operations.push(parse_operator(word)) if operator?(word)
    end
  end

  def integer?(text)
    text.to_i.to_s == text
  end

  def operator?(text)
    %w(plus minus multiplied divided).include?(text)
  end

  def parse_operator(text)
    return '+' if text.casecmp('plus') == 0
    return '-' if text.casecmp('minus') == 0
    return '*' if text.casecmp('multiplied') == 0
    return '/' if text.casecmp('divided') == 0
  end

  def calculate
    total = 0
    while @values.count > 1
      value1 = @values.shift
      value2 = @values.shift
      operation = @operations.shift
      total = value1.send operation, value2
      @values.unshift(total)
    end
    total
  end
end
