#!/env/rb
API_ROOT = 'Scripts/vx-ace-api'
require 'Scripts/vx-ace-api/vx_ace_api'

require 'Scripts/mods/advanced_game_time'
require 'Scripts/mods/euphoria_custom_gauge'  

module ADAAN
  POINTS = {
    :fed_homeless => 5, :broke_statue => 25
  }
  
  def self.add_points(key)
    points = POINTS[key]
    $game_actors[1].add_gauge(points)
  end
  
  def self.chop_tree
    # 3-5 knocks, with delay, different pitch
    # 2-4 random, then one at the end    
    count = 2 + rand(3)
    count.times do |i|
      RPG::SE.new('Knock', 100, 80 + rand(40)).play
      Game_Interpreter::instance.wait(25)
    end

    RPG::SE.new('Knock', 100, 80 + rand(40)).play
  end  
end