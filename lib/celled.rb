Celled = Struct.new(:x, :y) do
  def initialize
    self.x = -1
    self.y = 1
    @cell = 20
    @x_max = 24
    @y_max = 26
  end
  
  def left
    (11 + x * @cell)
  end
  
  def top
    (11 + y * @cell)
  end
end
