# This class represents an action that moves an agent from a start state to a result state (which may be the same state).
# It has a cost that is represented as a positive integer.

require 'action'
require 'state'

describe Action do

  it "should have a name, connect two states, and a cost function" do
    a = mock_state("a")
    b = mock_state("b")
    action = Action.new(a, b, "action_1", lambda{2})
    action.name.should == "action_1"
    action.start_state.should == a
    action.result_state.should == b
    action.get_cost.should == 2
  end

  it "should have a constructor that creates a default name from the start and result state and a default cost of {0}" do
    a = mock_state("a")
    b = mock_state("b")
    action = Action.create_with_default_name_and_cost(a, b)
    action.name.should == "a_to_b"
    action.get_cost.should == 0
  end

  it "should have a constructor that creates just a default cost" do
    a = mock_state("a")
    b = mock_state("b")
    name = "my_action"
    action = Action.create_with_default_cost(a, b, name)
    action.name.should == "my_action"
    action.get_cost.should == 0
  end

  it "should have a constructor that creates just a default name" do
    a = mock_state("a")
    b = mock_state("b")
    cost = lambda{2}
    action = Action.create_with_default_name(a, b, cost)
    action.name.should == "a_to_b"
    action.get_cost.should == 2
  end
  
  it "should automatically create an id for itself" do
    action = Action.new(mock_state, mock_state, "name", lambda{2})
    action.id.nil?.should == false
  end

  it "should implement comparable " do
    a1 = Action.new(mock_state, mock_state, "name", lambda{0})
    a2 = Action.new(mock_state, mock_state, "name", lambda{0})
    a3 = Action.new(mock_state, mock_state, "name", lambda{0})
    (a1 == a1).should == true
    (a1 == a2).should == false
    [a1,a2].include?(a1).should == true
    [a1,a2].include?(a3).should == false
  end

  it "should allow the cost function to be replaced at any time" do
    action = Action.new(mock_state, mock_state, "name", lambda{1})
    action.get_cost.should == 1
    action.cost_function = lambda{2 * 2}
    action.get_cost.should == 4
  end

  it "should allow an optional tick_count parameter to be passed when getting the cost" do
    action = Action.new(mock_state, mock_state, "name", lambda{|tick_count| tick_count * 2})
    action.get_cost(10).should == 20
  end

  def mock_state(name = "state_name")
    state = mock(State)
    state.stub!(:name).and_return(name)
    return state
  end

end

