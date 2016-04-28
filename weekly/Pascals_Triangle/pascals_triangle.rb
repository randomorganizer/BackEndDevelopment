# Creates Pascal's Triangle based on number of rows specified
class Triangle
  def initialize(rows)
    @rows = rows
  end

  def rows
    triangle = []
    @rows.times do
      triangle << create_row2(triangle.last)
    end
    triangle
  end

  private

  def create_row1(previous_row)
    return [1] if previous_row.nil?
    new_row = [1]
    index_a = 0
    index_b = 1
    (previous_row.count - 1).times do
      new_row << (previous_row[index_a] + previous_row[index_b])
      index_a += 1
      index_b += 1
    end
    new_row << 1
  end

  def create_row2(previous_row)
    return [1] if previous_row.nil?
    new_row = [1]
    index = [0,1]
    (1...previous_row.count).inject(index) do |index, _|
      new_row << (previous_row[index[0]] + previous_row[index[1]])
      index.map { |i| i + 1 }
    end
    new_row << 1
  end
end
