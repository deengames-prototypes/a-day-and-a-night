#!/env/rb
API_ROOT = 'Scripts/vx-ace-api'
require 'Scripts/vx-ace-api/vx_ace_api'

require 'Scripts/mods/advanced_game_time'
require 'Scripts/utils/custom_save_system'
require 'Scripts/utils/points_system'  
require 'Scripts/mods/global_common_events'

module ADAAN
  POINTS = {
    # Town map
    :fed_homeless => 10,
    # Masjid map
    :broke_statue => 40, :annoyed_student => -10, :listened_to_tafseer => 25, :paid_innkeeper => 10
  }
  
  # Game ends automagically at 8pm
  GAME_OVER = {:hour => 20, :minute => 0}
  
  def self.add_points(key)
    points = POINTS[key]
    PointsSystem.add_points(key, points)
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
    PointsSystem.add_points('Chopped down tree', -1)
  end
  
  def self.countdown_to_game_over
    if GameTime.hour? == GAME_OVER[:hour] && GameTime.min? == GAME_OVER[:minute]
      i = Game_Interpreter::instance
      i.show_message '\N[1] \{UGH!\|They got me!'
      i.show_message "Final score:\n\\{\\{#{PointsSystem.total_points} points!"
      i.game_over
    end
  end
end