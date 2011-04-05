class Calculator
  attr_reader :expr

  def initialize(expr='')
    @expr = expr
  end

  def add
    if @expr.empty?
      return 0
    else
      @expr.split(',').inject(0) do |sum,part|
        sum += part.to_i
      end
    end
  end
end
