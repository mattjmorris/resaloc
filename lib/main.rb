require 'armed_bandit_factory'
require 'reward_function_factory'

def show_current_info(bandit, action)

  puts "-"*30
  puts "Action: #{action}"
  puts "Current State: #{bandit.current_state.name}"
  puts "Current Cost: #{bandit.current_cost}"
  puts "Current Reward: #{bandit.current_reward}"
  puts "Cumulative Reward: #{bandit.cumulative_reward}"
  puts 

end

ArmedBanditFactory.set_number_of_arms(2)

ArmedBanditFactory.set_state_reward_functions({:arm1 => RewardFunctionFactory.fixed_response_function(2, 3),
                                               :arm2 => RewardFunctionFactory.fixed_response_function(3, 5)})

ArmedBanditFactory.set_action_cost_functions({:arm1_to_arm1 => lambda{0}, :arm1_to_arm2 => lambda{0},
                                              :arm2_to_arm1 => lambda{0}, :arm2_to_arm2 => lambda{0}})

bandit = ArmedBanditFactory.create

show_current_info(bandit, nil)

10.times do
  
  bandit.tick
  
  action = :stay_on_arm1
  bandit.do_action(action)

  show_current_info(bandit, action)
end