class IllFormedExpressionError < Exception
end

class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    @expr.split(/[,\n]/).inject(0) do |sum,part|
      raise IllFormedExpressionError if part.empty?
      raise IllFormedExpressionError, 'negatives not allowed' if part.chomp[0] == '-'
      sum += part.to_i
    end
  end
end
