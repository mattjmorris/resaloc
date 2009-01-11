
require 'state_machine'
require 'state'
require 'action'
require 'array_math'

class ArmedBanditFactory

  @@num_arms = 1
  @@reward_functions = nil
  @@cost_functions = nil
  
  def self.set_number_of_arms(num_arms)
    @@num_arms = num_arms
  end

  def self.set_state_reward_functions(reward_functions)
    validate_reward_functions(reward_functions)
    @@reward_functions = reward_functions
  end

  def self.set_action_cost_functions(cost_functions)
    validate_cost_functions(cost_functions)
    @@cost_functions = cost_functions
  end

  def self.create

    state_machine = StateMachine.new

    create_states(state_machine)

    create_actions_linking_all_states(state_machine)

    create_actions_linking_all_states_to_self(state_machine)

    return state_machine

  end

  private

  # make sure we have the correct number of reward functions, with the expected names
  def self.validate_reward_functions(reward_functions)
    
    raise ArgmentError, "Wrong number of reward functions, expected #{@@num_arms} but found #{reward_functions.size}" if reward_functions.size != @@num_arms

    @@num_arms.times {|x| raise ArgumentError, "Missing reward function name arm#{x+1}" unless reward_functions.keys.include?("arm#{x+1}".to_sym)}
    
  end

  # make sure we have the correct number of cost functions, with the expected names
  def self.validate_cost_functions(cost_functions)

    raise ArgumentError, "Wrong number of cost functions, expected #{fac(@@num_arms) + @@num_arms} but found #{cost_functions.size}" if cost_functions.size != fac(@@num_arms) + @@num_arms

    @@num_arms.times do |x|
      @@num_arms.times do |y|
        raise ArgumentError, "Missing cost function name arm#{x+1}_to_arm#{y+1}" unless cost_functions.keys.include?("arm#{x+1}_to_arm#{y+1}".to_sym)
      end
    end
    
  end
  
  # create the 'arms' of the bandit
  def self.create_states(state_machine)

    @@num_arms.times do |arm_num|
      state = State.new("arm#{arm_num+1}", get_reward_function(arm_num))
      state_machine << state
    end

  end
  
  # create actions that link all states together, but not actions that link states to themselves
  def self.create_actions_linking_all_states(state_machine)
    
    state_pairs = []
    # get all combos of pairs of states
    state_machine.states.perm(2){ |combo| state_pairs << combo }
    state_pairs.each do |state_pair|
      action = Action.new(state_pair[0], state_pair[1], "move_from_#{state_pair[0].name}_to_#{state_pair[1].name}", get_cost_function(state_pair[0].name, state_pair[1].name))
      state_machine << action
    end

  end

  # create actions to link each state to itself (recurrent action)
  def self.create_actions_linking_all_states_to_self(state_machine)
    state_machine.states.each{ |state| state_machine << Action.new(state, state, "stay_on_#{state.name}", get_cost_function(state.name, state.name)) }
  end

  def self.random_lambda_function(factor)
    return lambda{|tick_count| (tick_count % (rand(20)+1)) * rand(factor) }
  end

  def self.get_reward_function(arm_num)
    if @@reward_functions.nil?
      return random_lambda_function(10)
    else
      reward_function = @@reward_functions["arm#{arm_num+1}".to_sym]
      return reward_function
    end
  end

  def self.get_cost_function(state_1_name, state_2_name)
    if @@cost_functions.nil?
      return random_lambda_function(3)
    else
      cost_function = @@cost_functions["#{state_1_name}_to_#{state_2_name}".to_sym]
      return cost_function
    end
  end

  # factorial
  def self.fac(n)
    if n == 0
      1
    else
      n * fac(n-1)
    end
  end

end
