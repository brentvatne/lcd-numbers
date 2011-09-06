require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__),"../lcd"))

describe LcdNumberPrinter do
  before(:each) do
    @lcd = LcdNumberPrinter.new("1234", 2)
  end

  describe "#initialize" do
    it "should accept a string or array of numbers and produce an array of integers" do
      lcd_from_string = LcdNumberPrinter.new("1234", 1)
      lcd_from_array  = LcdNumberPrinter.new([1,2,3,4], 1)
      lcd_from_string.numbers.should == [1,2,3,4] 
      lcd_from_array.numbers.should  == [1,2,3,4]
    end
  end

  describe "helper methods" do
    describe "#is_horizontal_line?" do
      it "must return true if string is a horizontal line and false if not" do
        @lcd.is_horizontal_line?(" - ").should be_true  
        @lcd.is_horizontal_line?("   ").should be_false
        @lcd.is_horizontal_line?(" | ").should be_false
      end
    end
    describe "#is_vertical_line?" do
      it "must return true if string is a vertical line and false if not" do
        @lcd.is_vertical_line?(" - ").should be_false  
        @lcd.is_vertical_line?("   ").should be_false
        @lcd.is_vertical_line?(" | ").should be_true
      end
    end
    describe "#is_blank_line?" do
      it "must return true if string is a blank line and false if not" do
        @lcd.is_blank_line?(" - ").should be_false  
        @lcd.is_blank_line?("   ").should be_true
        @lcd.is_blank_line?(" | ").should be_false
      end
    end

    describe "scaling methods" do
      describe "#scale_number" do
        it "should scale the number properly" do
          size_two_two = [" -- ",
                          "   |",
                          "   |",
                          " -- ",
                          "|   ",
                          "|   ",
                          " -- "]
                             
          lcd_numbers = @lcd.lcd_numbers
          @lcd.scale_number(lcd_numbers[2]).should == size_two_two
        end
      end
      describe "#scale_horizontal_line" do
        it "must multiply the number of - in the line by the size" do
          @lcd.scale_horizontal_line(" - ").should == [" -- "]
        end
      end
      describe "#scale_vertical_line" do
        pending
      end
      describe "#scale_blank_line" do
        it "should return a blank line with num spaces equal to 2 + size" do
         base_size = 3
         size      = @lcd.size
         @lcd.scale_blank_line(" "*base_size).should == [" "*(2+size)] 
        end
      end
    end
  end

end
