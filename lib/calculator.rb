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
    raise IllFormedExceptionError, 'diff needs at least two numbers' if nums.length < 2
    nums[1..-1].inject(nums[0]) { |sum,n| sum -= n }
  end

  private

  def default_delims
    /[,\n]/
  end

  def split_off_custom_delims
    (first,rest) = @expr.split("\n", 2)
    if first =~ /^\/\/\[(.)\]$/
      [rest, %r{[#{Regexp.last_match(1)}\n]}]
    else
      [[first, rest].select { |s| s.class == String }.join("\n"), default_delims]
    end
  end

  def expr_to_numbers
    (expr,delims) = split_off_custom_delims
    nums = expr.split(delims).map { |part|
      raise IllFormedExpressionError, 'multiple consecutive delimiters not allowed' if part.empty?
      part.to_i
    }
    negatives = nums.select {|n| n < 0}
    raise IllFormedExpressionError, "negatives not allowed: #{negatives.join ','}" unless negatives.empty?
    return nums
  end
end
