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
      sum += part.to_i
    end
  end
end
