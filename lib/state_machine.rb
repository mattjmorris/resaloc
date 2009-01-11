
require File.dirname(__FILE__) + '/state'

class StateMachine

  attr_reader :current_state, :start_state, :current_cost, :current_reward, :cumulative_reward, :tick_count, :states, :actions

  def initialize
    @states = []
    @actions = []
    @current_state = nil
    @start_state = nil
    @current_cost = 0
    @current_reward = 0
    @cumulative_reward = 0
    @tick_count = 0
  end

  # Allows states and actions to be passed in, in array style.  Ex: state_machine << state1 << state2 << state3
  def <<(obj)

    if obj.class == State
      add_state(obj)
    elsif obj.class == Action
      add_action(obj)
    else
      raise ArgumentError, "StateMachine method << called with unexected object: #{obj}", caller
    end

    # return self so that multiple objects can be passed in a row
    return self

  end

  # The names of actions available for the current state
  def current_action_names
    return @actions.find_all{|a| a.start_state == @current_state}.map{|a| a.name}
  end

  # Perform an action, allowing an optional tick_count parameter to be passed in.
  def do_action(action_name)

    action = @actions.find{|a| a.name.eql?(action_name.to_s)}
    
    raise ArgumentError, "Action #{action.name} is not allowed from state #{@current_state.name}", caller unless
      current_action_names.include?(action.name)
      
    @current_state = action.result_state
    @current_cost = action.get_cost(tick_count)
    @current_reward = @current_state.get_reward(tick_count)
    @cumulative_reward += @current_reward - @current_cost
      
  end

  def tick
    @tick_count += 1
  end

  private

  def add_state(state)
    @current_state, @start_state = state, state if @states.empty?
    @states << state
  end

  def add_action(action)

    raise ArgumentError, "StateMachine given action #{action} with unknown state #{action.start_state}", caller unless @states.include?(action.start_state)
    raise ArgumentError, "StateMachine given action #{action} with unknown state #{action.result_state}", caller unless @states.include?(action.result_state)
    @actions << action
    
  end

end