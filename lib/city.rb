require File.join(File.dirname(__FILE__), "house")

class City
  def initialize
    @floors = Array.new(24) do |i|
      rand(20)
    end
    @houses = Array.new
    @floors.each_index do |index|
      @floors[index].times do |i|
        @houses.push House.new(index, 25 - i)
      end
    end
  end
  
  def explode (floor_x, floor_y)
    selected = @houses.select do |house|
      house.x == floor_x && house.y == floor_y
    end
    if selected.any?
      selected[0].remove
      @houses.delete selected[0]
      $score_value += 10
      $score.text = $score_value.to_s
      true
    else
      false
    end
  end
end
