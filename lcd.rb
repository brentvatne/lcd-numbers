require './lcd_characters'

class LcdNumberPrinter
  include LcdCharacters

  def initialize(numbers, size)
    @numbers, @size = numbers, size
  end

  def render
    output = []
    if @size == 1 
      @numbers.each { |n| output.push(LcdNumbers[n]); output.push(Spacer) }
    else
#transform depending on size
#for each line, if it is a horizontal line: 
#                - x * dash
#               if it is a vertical line: 
#                - replace \s* with (n+1) - (number of |)
#                - duplicate this line and add below
#               if it is a blank line:
#                - do nothing, for now. perhaps on odd or evens add duplicate

    end 
    (0..output.first.length).each do |i|
      output.each { |l| print l[i] }
      print "\n"
    end
  end

  def is_horizontal_line?(l)
    l.match(/^\s*-\s*$/)
  end

  def is_vertical_line?(l)
    l.match(/^\s*\|\s*$/)
  end

  def is_blank_line?(l)
    l.match(/^\s*$/)
  end
end

# ruby lcd.rb -s 1 6789   # s = 1
# ruby lcd.rb 6789        # s = 2
unless $*.empty?
  if $*.first == "-s" 
    size = $*[1].to_i
    numbers = $*[2].split(//).map(&:to_i)
  else
    size = 2
    numbers = $*.first.split(//).map(&:to_i)
  end

  lcd = LcdNumberPrinter.new(numbers, size)
  lcd.render
end
