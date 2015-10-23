#!/env/rb
API_ROOT = 'Scripts/vx-ace-api'
require 'Scripts/vx-ace-api/vx_ace_api'

require 'Scripts/mods/advanced_game_time'
require 'Scripts/utils/custom_save_system'
require 'Scripts/utils/points_system'  
require 'Scripts/mods/global_common_events'
require 'Scripts/mods/ace_message_system'

module ADAAN
  POINTS = {
    # Inn mapp
    :break_inn_door => -15,  :paid_innkeeper => 10, :didnt_pay_innkeeper => -10,
    # Town map
    :fed_homeless => 10,
    # Masjid map
    :broke_statue => 40, :annoyed_student => -10, :listened_to_tafseer => 25
  }
  
  # Game ends automagically at 8pm
  GAME_OVER = {:hour => 20, :minute => 0}
  
  def self.add_points(key)
    points = POINTS[key]
    PointsSystem.add_points(key, points)
  end
  
  def self.mine_ore
    repeat_n_times(3, 3, 'pickaxe')
  end
  
  def self.chop_tree
    repeat_n_times(3, 6, 'Knock')
    PointsSystem.add_points('Chopped down tree', -1)
  end
  
  def self.countdown_to_game_over
    if GameTime.hour? == GAME_OVER[:hour] && GameTime.min? >= GAME_OVER[:minute]
      i = Game_Interpreter::instance
      i.show_message '\N[1] \{UGH!\|They got me!'
      i.show_message "Final score:\n\\{\\{#{PointsSystem.total_points} points!"
      i.game_over
    end
  end
  
  private
  
  # pitch variance of 20 => 80-120
  # [min_times, max_times)
  # Repeat this sound min to max times, with random pitch variance
  def self.repeat_n_times(min_times, max_times, sound, pitch_variance = 20, delay = 25)
    count = min_times + rand(max_times - min_times).to_i
    count.times do |i|
      RPG::SE.new(sound, 100, 100 - pitch_variance + rand(pitch_variance * 2).to_i).play
      Game_Interpreter::instance.wait(delay)
    end
  end
end