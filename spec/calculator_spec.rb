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

    it 'should return the number in the string for a single number' do
      Calculator.new('42').add.should == 42
    end

    it 'should return the sum for an expr with two numbers' do
      Calculator.new('12,34').add.should == 46
    end

    it 'should return the sum for an arbitrary number of numbers' do
      Calculator.new('1,2,3').add.should == 6
      Calculator.new('1,2,5,8').add.should == 16
    end

    it 'should accept newlines for delimiters' do
      Calculator.new("1\n2\n3").add.should == 6
      Calculator.new("2,3\n4").add.should == 9
    end

    it 'should throw an exception for consecutive delimiters' do
      lambda {
        Calculator.new("1,\n2").add
      }.should raise_exception
      lambda {
        Calculator.new("1\n,2").add
      }.should raise_exception
    end

    it 'should throw an exception for negative numbers' do
      lambda {
        Calculator.new('-1').add
      }.should raise_exception
    end

    it 'should list negative numbers in thrown exception' do
      lambda {
        Calculator.new('-1').add
      }.should raise_exception(IllFormedExpressionError, "negatives not allowed: -1")
    end

    it 'should list all negative numbers in thrown exception' do
      lambda {
        Calculator.new("1,-2\n3,-4").add
      }.should raise_exception { |e|
        e.message.should == 'negatives not allowed: -2,-4'
      }
    end

    it 'should accept custom delimiters on the first line' do
      Calculator.new("//;\n1;2").add.should == 3
    end
  end

  describe 'diff' do
    it 'should return the difference of two numbers' do
      Calculator.new('1,0').diff.should == 1
      Calculator.new('3,2,1').diff.should == 0
      Calculator.new("5,4\n3,2\n1").diff.should == -5
    end

    it 'should throw an exception for fewer than 2 numbers' do
      lambda {
        Calculator.new('5').diff
      }.should raise_exception
      lambda {
        Calculator.new('').diff
      }.should raise_exception
    end

    it 'should throw an exception for consecutive delimiters' do
      lambda {
        Calculator.new("1,\n2").diff
      }.should raise_exception
      lambda {
        Calculator.new("1\n,2").diff
      }.should raise_exception
    end

    it 'should throw an exception for negative numbers' do
      lambda {
        Calculator.new('-1').diff
      }.should raise_exception
    end

    it 'should list negative numbers in thrown exception' do
      lambda {
        Calculator.new('-1').diff
      }.should raise_exception(IllFormedExpressionError, "negatives not allowed: -1")
    end

    it 'should list all negative numbers in thrown exception' do
      lambda {
        Calculator.new("1,-2\n3,-4").diff
      }.should raise_exception { |e|
        e.message.should == 'negatives not allowed: -2,-4'
      }
    end
  end
end
