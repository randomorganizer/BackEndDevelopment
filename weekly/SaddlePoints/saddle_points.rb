# Matrix takes a matrix in string format and finds all saddle points
class Matrix
  def initialize(matrix)
    @matrix = []
    parse_matrix(matrix)
  end

  def rows
    @matrix
  end

  def columns
    @matrix.transpose
  end

  def saddle_points
    saddlepoints = []
    @matrix.each_with_index do |row_obj, row|
      row_obj.each_with_index do |_obj, col|
        saddlepoints << [row, col] if saddle_point?(row, col)
      end
    end
    saddlepoints
  end

  private

  def parse_matrix(matrix)
    matrix.each_line do |line|
      @matrix.push(line.chomp.split.map(&:to_i))
    end
  end

  def saddle_point?(row, col)
    @matrix[row].max == @matrix[row][col] &&
      @matrix.transpose[col].min == @matrix[row][col]
  end
end
