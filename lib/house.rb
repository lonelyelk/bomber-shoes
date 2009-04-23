require File.join(File.dirname(__FILE__), "celled")

class House < Celled
  def initialize(floor_x, floor_y)
    super()
    self.x = floor_x
    self.y = floor_y + 1
    @image = $app.image File.join(File.dirname(__FILE__), "..", "img", "house.png"), :left => left, :top => top
  end

  def remove
    @image.remove
  end
end