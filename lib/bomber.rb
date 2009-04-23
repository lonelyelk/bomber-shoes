require File.join(File.dirname(__FILE__), "city")
require File.join(File.dirname(__FILE__), "plane")
require File.join(File.dirname(__FILE__), "bomb")
IMAGE_PATH = File.join(File.dirname(__FILE__), "..", "img")

class Bomber < Shoes
  url "/", :intro
  url "/game", :game
  url "/final", :final
  
  def intro
    background File.join(IMAGE_PATH, "bg.png")
    image File.join(IMAGE_PATH, "instruction.png"), :top => 100, :left => 120
    image File.join(IMAGE_PATH, "start_btn.png"), :top => 300, :left => 180, :click => "/game"
  end
  
  def game
    background File.join(IMAGE_PATH, "bg.png")
    $score_value = 0
    $score = para $score_value.to_s, :top => 5, :left => 10
    $city = City.new
    @plane = Plane.new
    keypress do |k|
      if k == " "
        if @bomb.nil? or @bomb.removed?
          @bomb = Bomb.new(@plane.x, @plane.y)
        end
      end
    end
    animate(20) do |i|
      if @plane and !@plane.removed?
        @plane.run
      end
      if @bomb and !@bomb.removed?
        @bomb.run
      end
      if @plane and @plane.removed?
        visit "/final"
      end
    end
  end
  
  def final
    begin
    background File.join(IMAGE_PATH, "bg.png")
    image File.join(IMAGE_PATH, "final.png"), :top => 100, :left => 120
    stack :top => 200, :width => "100%" do
      subtitle $score_value.to_s, :align => "center"
    end
    image File.join(IMAGE_PATH, "again_btn.png"), :top => 300, :left => 150, :click => "/game"
    rescue Exception => e
    alert e.to_s
    end
  end
end
