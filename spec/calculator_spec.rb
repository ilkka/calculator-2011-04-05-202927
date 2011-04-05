require 'spec_helper'
require 'calculator'

describe Calculator do
  describe "new" do
    it "should instantiate" do
      lambda {
        Calculator.new
      }.should_not raise_exception
    end
    
    it "should take a string of numbers separated with commas" do
      lambda {
        Calculator.new '1,2'
      }.should_not raise_exception
    end
  end

  describe "expr" do
    it "should return the expression passed in to the initializer" do
      c = Calculator.new '1,2'
      c.expr.should == '1,2'
    end
  end

  describe 'add' do
    it 'should return zero for an empty string' do
      Calculator.new('').add.should == 0
    end
  end
end
