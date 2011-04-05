class IllFormedExpressionError < Exception
end

class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    expr_to_numbers.inject(0) { |sum,n| sum += n }
  end

  def diff
    nums = expr_to_numbers
    nums[1..-1].inject(nums[0]) { |sum,n| sum -= n }
  end

  private

  def expr_to_numbers
    nums = @expr.split(/[,\n]/).map { |part|
      raise IllFormedExpressionError, 'multiple consecutive delimiters not allowed' if part.empty?
      part.to_i
    }
    negatives = nums.select {|n| n < 0}
    raise IllFormedExpressionError, "negatives not allowed: #{negatives.join ','}" unless negatives.empty?
    return nums
  end

end
