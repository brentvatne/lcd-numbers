require './lcd_characters'

class LcdNumberPrinter
  include LcdCharacters
  attr_reader :numbers, :size

  def initialize(numbers, size = 2)
    numbers = numbers.split(//).map(&:to_i) if numbers.respond_to?(:split)
    @numbers, @size = numbers, size
    @scaled_lcd_numbers = generate_scaled_numbers
  end

  def lcd_numbers
    LcdNumbers
  end

  def scale_vertical_line(l)
    if is_vertical_line?(l)
      new_l = ""
      if l.match(/\s+\|\s+/)
        new_l = l.gsub(/\s+/," "*((@size + 2 - number_of_vertical_lines_in(l))/2))
        new_l += " " if @size % 2 == 0
      else
        new_l = l.gsub(/\s+/," "*(@size + 2 - number_of_vertical_lines_in(l)))  
      end
      [new_l, new_l]
    end
  end

  def number_of_vertical_lines_in(l)
    l.split("").inject(0) do |count, char| 
      char.match(/\|/) ? count + 1 : count
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
    return n if @size == 1
    scaled_n = []
    n.each do |l|
      scaled_lines = scale_vertical_line(l)   ||
                     scale_horizontal_line(l) ||
                     scale_blank_line(l)
      raise "Invalid LcdNumber string #{l}" unless scaled_lines
      scaled_lines.each { |sl| scaled_n.push(sl) }
    end 
    scaled_n
  end

  def generate_scaled_numbers
    LcdNumbers.map { |n| scale_number(n) }
  end

  def render
    output = []
    @numbers.each { |n| output.push(@scaled_lcd_numbers[n]); output.push(Spacer) }
    (0..output.first.length).each do |i|
      output.each { |l| print l[i] }
      print "\n"
    end
  end

  def is_horizontal_line?(l)
    l.match(/^\s*-\s*$/)
  end

  def is_vertical_line?(l)
    l.match(/^\s*\|\s*$/) || l.match(/^\|\s*\|$/)
  end

  def is_blank_line?(l)
    l.match(/^\s*$/)
  end
end

# ruby lcd.rb -s 1 6789   # s = 1
# ruby lcd.rb 6789        # s = 2
unless $*.empty? || $*.first == "spec"
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
