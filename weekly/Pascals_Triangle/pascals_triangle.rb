class Triangle

  def initialize(rows)
    @rows = rows

  end

  def rows
    triangle = []
    @rows.times do
      triangle << create_row(triangle.last)
    end
    triangle
  end

  private

  def create_row(previous_row)
    return [1] if previous_row == nil
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

end