
require 'armed_bandit_factory'

describe ArmedBanditFactory do

  it "should create an n-armed bandit with randomized cost and reward functions if cost and reward functions are not specified" do

    ArmedBanditFactory.set_number_of_arms(2)
    bandit = ArmedBanditFactory.create
    bandit.current_state.name.should == "arm1"
    bandit.current_cost.should == 0
    bandit.current_reward.should == 0
    bandit.cumulative_reward.should == 0

    bandit.current_action_names.include?("move_from_arm1_to_arm2").should == true
    bandit.current_action_names.include?("stay_on_arm1").should == true

    bandit.tick
    bandit.do_action(:stay_on_arm1)
    bandit.current_state.name.should == "arm1"
    bandit.current_action_names.include?("move_from_arm1_to_arm2").should == true
    bandit.current_action_names.include?("stay_on_arm1").should == true

#p bandit.current_cost
#p bandit.current_reward
#p bandit.cumulative_reward

    bandit.tick
    bandit.do_action(:move_from_arm1_to_arm2)
    bandit.current_state.name.should == "arm2"
    bandit.current_action_names.include?("move_from_arm2_to_arm1").should == true
    bandit.current_action_names.include?("stay_on_arm2").should == true
    
#p bandit.current_cost
#p bandit.current_reward
#p bandit.cumulative_reward

  end

  it "should create an n-armed bandit with specified cost and reward functions" do

    ArmedBanditFactory.set_number_of_arms(3)

    ArmedBanditFactory.set_state_reward_functions({:arm1 => lambda{1}, :arm2 => lambda{2}, :arm3 => lambda{3}})
    ArmedBanditFactory.set_action_cost_functions({
      :arm1_to_arm1 => lambda{0}, :arm1_to_arm2 => lambda{1}, :arm1_to_arm3 => lambda{2},
      :arm2_to_arm1 => lambda{3}, :arm2_to_arm2 => lambda{4}, :arm2_to_arm3 => lambda{5},
      :arm3_to_arm1 => lambda{6}, :arm3_to_arm2 => lambda{7}, :arm3_to_arm3 => lambda{8}
    })
    bandit = ArmedBanditFactory.create

    bandit.current_state.name.should == "arm1"
    bandit.current_cost.should == 0
    bandit.current_reward.should == 0
    bandit.cumulative_reward.should == 0

    bandit.do_action(:stay_on_arm1)
    bandit.current_cost.should == 0
    bandit.current_reward.should == 1
    bandit.cumulative_reward.should == 1

    bandit.do_action(:move_from_arm1_to_arm2)
    bandit.current_cost.should == 1
    bandit.current_reward.should == 2
    bandit.cumulative_reward.should == 2

    bandit.do_action(:stay_on_arm2)
    bandit.current_cost.should == 4
    bandit.current_reward.should == 2
    bandit.cumulative_reward.should == 0

    bandit.do_action(:move_from_arm2_to_arm3)
    bandit.current_cost.should == 5
    bandit.current_reward.should == 3
    bandit.cumulative_reward.should == -2

    bandit.do_action(:stay_on_arm3)
    bandit.current_cost.should == 8
    bandit.current_reward.should == 3
    bandit.cumulative_reward.should == -7

  end

end

