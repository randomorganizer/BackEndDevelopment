# House class recites a rhyme
class House
  def self.recite
    rhyme = ''
    pieces.count.times do |paragraph|
      rhyme << "This is #{pieces[11 - paragraph][0]}#{(paragraph == 0) ? '.' : ''}\n"
      (12 - paragraph).upto(11) do |line|
        rhyme << "#{pieces[line - 1][1]} #{pieces[line][0]}#{(line == 11) ? '.' : ''}\n"
      end
      rhyme << "\n" unless paragraph == 11
    end
    rhyme
  end

  private

  def self.pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
