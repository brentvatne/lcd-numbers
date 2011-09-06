require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__),"../lcd"))

describe LcdNumberPrinter do
  before(:each) do
    @lcd = LcdNumberPrinter.new
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
  end

end
