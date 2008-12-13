# A state of the environment, containing some number of actions

require File.dirname(__FILE__) + '/auto_id'

class State
  include AutoId

  attr_accessor :actions
  attr_reader :name, :reward, :id

  def initialize(name, reward)
    @name = name
    @reward = reward
    @actions = []
    assign_id(id)
  end

end

