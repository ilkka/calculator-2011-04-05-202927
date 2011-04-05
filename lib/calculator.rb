class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    if @expr.empty?
      return 0
    else
      return @expr.to_i
    end
  end
end
