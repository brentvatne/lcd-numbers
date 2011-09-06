# ruby lcd.rb -s 1 6789   # s = 1
# ruby lcd.rb 6789        # s = 2
if $*.first == "-s" 
  size = $*[1]
  numbers = $*[2].split(//).map(&:to_i)
else
  size = 2
  numbers = $*.first.split(//).map(&:to_i)
end

n_as_lcd = []
n_as_lcd[0] = [ " - ",
               "| |",
               "   ",
               "| |",
               " - " ]

n_as_lcd[1] = [ "   ",
               " | ",
               "   ",
               " | ",
               "   " ]

n_as_lcd[2] = [ " - ",
               "  |",
               " - ",
               "|  ",
               " - " ]
n_as_lcd[3] = [ " - ",
               "  |",
               " - ",
               "  |",
               " - " ]
n_as_lcd[4] = [ "   ",
               "| |",
               " - ",
               "  |",
               "   " ]
n_as_lcd[5] = [ " - ",
               "|  ",
               " - ",
               "  |",
               " - " ]
n_as_lcd[6] = [ " - ",
               "|  ",
               " - ",
               "| |",
               " - " ]
n_as_lcd[7] = [ " - ",
               "  |",
               "   ",
               "  |",
               "   " ]
n_as_lcd[8] = [ " - ",
               "| |",
               " - ",
               "| |",
               " - " ]
n_as_lcd[9] = [ " - ",
               "| |",
               " _ ",
               "  |",
               " - " ]
spacer = [ " ", " ", " ", " ", " "]

output = []

numbers.each { |n| output.push(n_as_lcd[n]); output.push(spacer) }

(0..output.first.length).each do |i|
  output.each { |l| print l[i] }
  print "\n"
end
# render(numbers)
# each size: o 
