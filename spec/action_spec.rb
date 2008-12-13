# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'action'
require 'state'

describe Action do

  it "should be initialized with a name, value, and result state" do
    result_state = mock_state
    a1 = Action.new("action_1", 1, result_state)
    a1.name.should == "action_1"
    a1.cost.should == 1
    a1.result_state.should == result_state
  end
  
  it "should automatically create an id for itself" do
    a1 = Action.new("action_1", -1, mock_state)
    a1.id.nil?.should == false
  end

  def mock_state
    return mock(State)
  end

end

