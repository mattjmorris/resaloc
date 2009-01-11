
require File.dirname(__FILE__) + '/auto_id'

class State
  include AutoId

  attr_accessor :reward_function
  attr_reader :name, :id

  # Name of the state and a reward function lambda )
  def initialize(name, reward_function)
    @name = name
    @reward_function = reward_function
    assign_id(id)
  end

  def self.create_with_default_reward(name)
    return self.new(name, lambda{0})
  end

  def get_reward(tick_count = nil)
    return @reward_function.call(tick_count)
  end

end
