# An action that has a value (usually negative, representing the cost of the action)
# and a resulting state.  Actions are assigned to states.

require File.dirname(__FILE__) + '/auto_id'

class Action
  include AutoId

  attr_accessor :cost_function
  attr_reader :name, :start_state, :result_state, :id

  def initialize(start_state, result_state, name, cost_function)
    @start_state = start_state
    @result_state = result_state
    @name = name
    @cost_function = cost_function
    assign_id(id)
  end

  def self.create_with_default_name_and_cost(start_state, result_state)
    name = start_state.name + "_to_" + result_state.name
    return self.new(start_state, result_state, name, lambda{0})
  end

  def self.create_with_default_name(start_state, result_state, cost_function)
    name = start_state.name + "_to_" + result_state.name
    return self.new(start_state, result_state, name, cost_function)
  end

  def self.create_with_default_cost(start_state, result_state, name)
    return self.new(start_state, result_state, name, lambda{0})
  end

  def get_cost(tick_count = nil)
    @cost_function.call(tick_count)
  end

end
