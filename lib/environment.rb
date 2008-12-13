
require 'observer'
require File.dirname(__FILE__) + '/state'

class Environment
#  include Observable

  def initialize(states)
    @states = states
  end

  def tick
    @schedule.tick
    notify_observers(@state)
  end

  # called by the schedules that the environment has registered with
  def update(state)
    changed
    @state = state
  end

end

