# An action that has a value (usually negative, representing the cost of the action)
# and a resulting state.  Actions are assigned to states.

require 'auto_id'

class Action
  include AutoId

  attr_reader :name, :cost, :result_state, :id

  def initialize(name, cost, result_state)
    @name = name
    @cost = cost
    @result_state = result_state
    assign_id(id)
  end

end
