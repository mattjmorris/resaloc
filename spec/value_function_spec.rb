## To change this template, choose Tools | Templates
## and open the template in the editor.
#
#require 'value_function'
#require 'state'
#require 'action'
#
#describe ValueFunction do
#  before(:each) do
#    @value_function = ValueFunction.new
#  end
#
#  it "should estimate values of state-action pairs based on average of state reward minus action cost" do
#
#    state_action_sequences = []
#
#    (1..2).each do |i|
#
#      s1 = mock_state(1, i)
#      s2 = mock_state(2, i*2)
#      s3 = mock_state(3, i*3)
#
#      a1 = mock_action(1, i)
#      a2 = mock_action(2, i+1)
#      a3 = mock_action(3, i+2)
#
#      state_action_sequences << [s1, a1] # 1-1 + 2-2 / 2 = 0
#      state_action_sequences << [s1, a2] # 1-2 + 2-3 / 2 = -1
#      state_action_sequences << [s1, a3] # 1-3 + 2-4 / 2 = -2
#      state_action_sequences << [s2, a1] # 2-1 + 4-2 / 2 = 1.5
#      state_action_sequences << [s2, a2] # 2-2 + 4-3 / 2 = 0.5
#      state_action_sequences << [s2, a3] # 2-3 + 4-4 / 2 = -0.5
#      state_action_sequences << [s3, a1] # 3-1 + 6-2 / 2 = 2.5
#      state_action_sequences << [s3, a2] # 3-2 + 6-3 / 2 = 2
#      state_action_sequences << [s3, a3] # 3-3 + 6-4 / 2 = 1
#
#    end
#
#    state_action_sequences.each do |state_action|
#      state = state_action[0]
#      action = state_action[1]
#      @value_function.set_state_action_result(state, action, state.reward - action.cost)
#    end
#
#    @value_function.get_state_action_value(s1, a1).should == 0
#
#
#
#  end
#
#  def mock_state(id, reward)
#    state = mock(State)
#    stub!(:id).and_return(id)
#    stub!(:reward).and_return(reward)
#    return state
#  end
#
#  def mock_action(id, cost)
#    action = mock(Action)
#    stub!(:id).and_return(id)
#    stub!(:cost).and_return(cost)
#    return action
#  end
#
#end
#
