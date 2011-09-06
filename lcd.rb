require './lcd_characters'

class LcdNumberPrinter
  include LcdCharacters
  attr_reader :numbers, :size

  def initialize(numbers, size = 2)
    numbers = numbers.split(//).map(&:to_i) if numbers.respond_to?(:split)
    @numbers, @size = numbers, size
  end

  def lcd_numbers
    LcdNumbers
  end

#transform depending on size
#for each line, if it is a horizontal line: 
#                - x * dash
#               if it is a vertical line: 
#                - replace \s* with (n+1) - (number of |)
#                - duplicate this line and add below
#               if it is a blank line:
#                - 2 + size number of blank spots
#                - maybe on odds or events add an extra or sthing 

  def scale_vertical_line(l)
    if is_vertical_line?(l)
      
    end
  end

  def scale_horizontal_line(l)
    if is_horizontal_line?(l)
      [l.gsub("-","-"*@size)]
    end
  end

  def scale_blank_line(l) 
    if is_blank_line?(l)
      [l.gsub(/^\s*$/," "*(2 + @size))]
    end
  end

  def scale_number(n)
    scaled_n = []
    n.each do |l|
      scaled_l = scale_vertical_line(l)   ||
                 scale_horizontal_line(l) ||
                 scale_blank_line(l)
      raise "Invalid LcdNumber string" unless scaled_l
      scaled_l.each { |sl| scaled_n.push(sl) }
    end 
    scaled_n
  end

  def render
    output = []
    scaled_lcd_numbers = []
    if @size == 1 
      @numbers.each { |n| output.push(LcdNumbers[n]); output.push(Spacer) }
    else
      scaled_lcd_numbers = []
      LcdNumbers.each do |n|
        scaled_lcd_numbers.push scale_number(n)
      end

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

  #lcd = LcdNumberPrinter.new(numbers, size)
  #lcd.render
end
