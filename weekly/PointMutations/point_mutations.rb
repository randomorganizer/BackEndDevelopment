# DNA class calculates mutations between 2 strands
class DNA
  def initialize(strand1)
    @strand1 = strand1
  end

  def hamming_distance(strand2)
    count = 0
    strand2 = strand2.chars
    @strand1.chars[0...strand2.size].each_with_index do |item, idx|
      count += 1 if item != strand2[idx]
    end
    count
  end
end
