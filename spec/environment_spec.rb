# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.dirname(__FILE__) + '/../lib/environment'

describe Environment do
  before(:each) do
    
  end

  it "should be initialized with a state machine" do
    @environment = Environment.new(mock_state_machine)
  end

  def mock_state_machine
    state_machine = mock(StateMachine)
   
  end

end

