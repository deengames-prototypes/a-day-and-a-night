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
end