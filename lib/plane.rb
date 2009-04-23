require File.join(File.dirname(__FILE__), "celled")

class Plane < Celled
  def initialize
    super
    @image = $app.image File.join(File.dirname(__FILE__), "..", "img", "plane.png"), :left => left, :top => top
    @pause = 0.5
    @acc = 0.9
    @removed = false
    @timer = Time.now.to_f
  end
  
  def run
    if Time.now.to_f > @timer + @pause and !removed?
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
    if @explode
      remove
    else
      self.x += 1
      if x > @x_max
        self.x = -1
        self.y += 1
        @pause *= @acc
      end
      if y <= @y_max
        self.explode = $city.explode(x, y)
        @image.move left, top
      else
        remove
      end
    end
  end
  
  def remove
    @image.remove
    @removed = true
  end
end
