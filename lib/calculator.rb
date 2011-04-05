class IllFormedExpressionError < Exception
end

class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    nums = @expr.split(/[,\n]/).map { |part|
      raise IllFormedExpressionError, 'multiple consecutive delimiters not allowed' if part.empty?
      part.to_i
    }
    negatives = nums.select {|n| n < 0}
    raise IllFormedExpressionError, "negatives not allowed: #{negatives.join ','}" unless negatives.empty?
    nums.inject(0) { |sum,n| sum += n }
  end
end
