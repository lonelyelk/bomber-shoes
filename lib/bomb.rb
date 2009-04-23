require File.join(File.dirname(__FILE__), "celled")

class Bomb < Celled
  def initialize(plane_x, plane_y)
    super()
    self.x = plane_x
    self.y = plane_y + 1
    @image = $app.image File.join(File.dirname(__FILE__), "..", "img", "bomb.png"), :left => left, :top => top
    @pause = 0.2
    self.explode = $city.explode(x, y)
    @force = 6
    @removed = false
    @timer = Time.now.to_f
  end
  
  def run
    if Time.now.to_f > @timer + @pause
      @timer = Time.now.to_f
      move
    end
  end
  
  def explode=(expl)
    @explode = expl
    @image.path = File.join(File.dirname(__FILE__), "..", "img", "explosion.png") if @explode
  end
  
  def removed?
    @removed
  end
  
  def move
    if @force > 0
      self.y += 1
      if y <= @y_max
        self.explode = $city.explode(x, y)
        @force -= 1 if @explode
        @image.move left, top
      elsif @explode
        remove
      else
        self.explode = true
      end
    else
      remove
    end
  end
  
  def remove
    @image.remove
    @removed = true
  end
end
