class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    @expr.split(/[,\n]/).inject(0) do |sum,part|
      sum += part.to_i
    end
  end
end
