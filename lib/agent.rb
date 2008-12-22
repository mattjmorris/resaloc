require File.dirname(__FILE__) + '/environment'
require File.dirname(__FILE__) + '/state'

class Agent
  attr_accessor :state
  attr_reader :name, :bank, :action

  def initialize(name, state)
    @name = name
    @new_state = state
    @bank = 0
    @value_function = {}
    @new_state_action_count = {}
    initialize_policy
  end

  def tick

    select_action
    
    get_new_state

    calculate_reward

    update_state_action_count

    update_value_function

  end


  private

  def select_action

    normalize_policy_values

    rand_num = rand
    selected_action = nil
    cum_preference = 0
    @policy.each do |action, preference_val|
      cum_preference += preference_val
      if cum_preference > rand_num
        selected_action = action
        break
      end
    end

    @action = selected_action

  end

  def normalize_policy_values
    sum = 0
    @policy.each_value { |preference_val| sum += preference_val }
    @policy.each_value { |preference_val| preference_val = preference_val / sum }
  end

  def initialize_policy
    @policy = {}
    num_actions = @new_state.actions.size
    @new_state.actions.each {|action| @policy[action] = 1.0/num_actions}
  end

  def update_state_action_count
    @state_action_count ||= {}
    @state_action_count[@previous_state] ||= {}
    @state_action_count[@previous_state][@action] ||= 0
    @state_action_count[@previous_state][@action] += 1
  end

  def update_value_function

    @value_function ||= {}
    @value_function[@previous_state] ||= {}
    # if this is our first time taking this action from the previous state
    if @state_action_count[@previous_state][@action] == 1
      @value_function[@previous_state][@action] = @reward_minus_cost
    else
      @value_function[@previous_state][@action] += (1.0/@state_action_count[@previous_state][@action]) * (@reward_minus_cost - @value_function[@previous_state][@action])
    end

    puts
    puts "action selected was #{@action.name}"
    puts "count = #{@state_action_count[@previous_state][@action]}"
    puts "reward_minus_cost = #{@reward_minus_cost}"
    puts "update amount = #{1.0/@state_action_count[@previous_state][@action]} * #{@reward_minus_cost} = #{1.0/@state_action_count[@previous_state][@action] * @reward_minus_cost}"
    @value_function[@previous_state].each {|action, value| puts "action: #{action.name}, value: #{value}"}

  end

  def get_new_state
    @previous_state = @new_state
    @new_state = @action.result_state
  end

  def calculate_reward
    @reward_minus_cost = @new_state.reward - @action.cost
    @bank += @reward_minus_cost
  end


end
