class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    return 0 if @expr.empty?
  end
end
