require 'spec'
require File.dirname(__FILE__) + '/../../../lib/agent'
require File.dirname(__FILE__) + '/../../../lib/state'
require File.dirname(__FILE__) + '/../../../lib/environment'

Before do
  @environment = Environment.new(setup_initial_state)
end

After do
end

Given /^"I am interacting with an Environment"$/ do
  @agent = Agent.new("steve", @environment)
end

When /^"I enter a new state"$/ do
  @state = true
end

Then /^"I should be given information about that state"$/ do
  @state.should == true
end

#Given "I am interacting with an Environment" do
##  @environment = Environment.new
#  @environment = 'my environment'
#end

#When 'I enter a new state' do
##  @environment.action = mock_action
#  @state = true
#end
#
#Then 'I should be given information about that state' do
##  @agent.current_state.should == @current_state
#  @state.should == true
#end


def setup_initial_state

  state_a = State.new("a", 0)
  state_b = State.new("b", 0)
  state_c = State.new("c", 10)

  action_a_b = Action.new("move_to_b", -1, state_b)

  action_a_c = Action.new("move_to_c", -1, state_c)

  state_a.actions = [action_a_b, action_a_c]

  return state_a
  
end

