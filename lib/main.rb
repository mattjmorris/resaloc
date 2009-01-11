require 'armed_bandit_factory'

ArmedBanditFactory.set_number_of_arms(2)

ArmedBanditFactory.set_state_reward_functions({:arm1 => lambda{1}, :arm2 => lambda{2}, :arm3 => lambda{3}})
ArmedBanditFactory.set_action_cost_functions({
  :arm1_to_arm1 => lambda{0}, :arm1_to_arm2 => lambda{1}, :arm1_to_arm3 => lambda{2},
  :arm2_to_arm1 => lambda{3}, :arm2_to_arm2 => lambda{4}, :arm2_to_arm3 => lambda{5},
  :arm3_to_arm1 => lambda{6}, :arm3_to_arm2 => lambda{7}, :arm3_to_arm3 => lambda{8}
})
bandit = ArmedBanditFactory.create