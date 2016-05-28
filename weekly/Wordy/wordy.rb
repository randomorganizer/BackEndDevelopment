# WordProblem calculates math problems given in natural language
require 'pry'
class WordProblem
  def initialize(question, use_order_of_operation=false)
    @use_ooo = use_order_of_operation
    @question = question
    @values = []
    @operations = []
  end

  def answer
    parse_question
    validate_question
    return calculate_with_ooo if @use_ooo
    calculate_without_ooo
  end

  private

  def parse_question
    @question.slice!('?')
    words = @question.split
    words.each do |word|
      @values.push(word.to_i) if integer?(word)
      @operations.push(parse_operator(word)) if operator?(word)
    end
  end

  def validate_question
    raise ArgumentError, 'No valid values stated' if @values.count == 0
    raise ArgumentError, 'Must provide more than 1 number' if @values.count == 1
    raise ArgumentError, 'Must specify operation' if @operations.count == 0
  end

  def calculate_with_ooo
    total = 0
    while @values.count > 1
      next_operation_index = @operations.index { |op| op == '*' || op == '/' }
      next_operation_index ||= 0
      operation = @operations.slice!(next_operation_index)
      value1 = @values.slice!(next_operation_index)
      value2 = @values.slice!(next_operation_index)
      total = value1.send operation, value2
      @values.insert(next_operation_index, total)
    end
    total
  end

  def calculate_without_ooo
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


end
