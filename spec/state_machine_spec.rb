# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'state_machine'
require 'state'
require 'action'

describe StateMachine do

  before(:each) do
   @state_machine = StateMachine.new
  end

  it "should make the first added state both the start state and the initial current state" do
    set_states
    @state_machine.current_state.should == @a
  end

  it "should give the names of allowable actions for the current state" do
    set_states
    set_actions
    @state_machine.current_action_names.include?("a_to_b").should == true
    @state_machine.current_action_names.include?("a_to_d").should == true
  end

  it "should accept an allowable action" do
    set_states
    set_actions
    selected_action = @state_machine.current_action_names[rand(@state_machine.current_action_names.length)]
    lambda{@state_machine.do_action(selected_action)}.should_not raise_error(Exception)
  end

  it "should raise an exception if asked to perform an action that does not have the current state as its start_state" do
    set_states
    set_actions
    @state_machine.current_state.should == @a
    lambda{@state_machine.do_action(:b_to_c)}.should raise_error(ArgumentError)
  end

  it "should only allow actions to be added if the action connects states that the state machine knows about" do

    a = State.create_with_default_reward("a")
    b = State.create_with_default_reward("b")

    lambda{@state_machine << Action.create_with_default_name_and_cost(a, b)}.should raise_error(ArgumentError)

    @state_machine << a
    lambda{@state_machine << Action.create_with_default_name_and_cost(a, b)}.should raise_error(ArgumentError)

    @state_machine << b
    lambda{@state_machine << Action.create_with_default_name_and_cost(a, b)}.should_not raise_error(ArgumentError)

  end

  it "should tick" do

    state_a = State.new("a", lambda{|tick_count| tick_count * 2})
    action_a = Action.new(state_a, state_a, "stay_on_a", lambda{|tick_count| tick_count})
    @state_machine << state_a << action_a
    @state_machine.tick_count.should == 0

    @state_machine.tick
    @state_machine.tick_count.should == 1

    @state_machine.do_action(:stay_on_a)
    @state_machine.current_cost.should == 1
    @state_machine.current_reward.should == 2
    @state_machine.cumulative_reward.should == 1

    @state_machine.tick
    @state_machine.tick
    @state_machine.tick_count.should == 3

    @state_machine.do_action(:stay_on_a)
    @state_machine.current_cost.should == 3
    @state_machine.current_reward.should == 6
    @state_machine.cumulative_reward.should == 4

  end

#  it "should not allow actions with duplicate names to be added" do
#
#    a = State.new()
#
#  end

  it "should allow traversal of complex state action diagrams" do

    set_states
    set_actions

    @state_machine.current_state.should == @a

    @state_machine.do_action(:a_to_b)
    @state_machine.current_state.should == @b

    @state_machine.do_action(:b_to_c)
    @state_machine.current_state.should == @c

    @state_machine.do_action(:c_to_c)
    @state_machine.current_state.should == @c

    @state_machine.do_action(:c_to_a)
    @state_machine.current_state.should == @a

  end

  it "should deliver costs and rewards that result from actions" do

    set_states
    set_actions

    @state_machine.current_cost.should == 0
    @state_machine.current_reward.should == 0
    @state_machine.cumulative_reward.should == 0

    @state_machine.do_action(:a_to_b)
    @state_machine.current_cost.should == 1
    @state_machine.current_reward.should == 0
    @state_machine.cumulative_reward.should == -1

    @state_machine.do_action(:b_to_c)
    @state_machine.current_cost.should == 2
    @state_machine.current_reward.should == 10
    @state_machine.cumulative_reward.should == 7

  end

  private

  # a[0], b[0], c [+10], d[0], e[+5]
  def set_states

    @a = State.create_with_default_reward("a")
    @b = State.create_with_default_reward("b")
    @c = State.new("c", lambda{10})
    @d = State.create_with_default_reward("d")
    @e = State.new("e", lambda{5})

    @state_machine << @a << @b << @c << @d << @e

  end

  # a (-1) --> b (-2) --> c (0) --> a
  # |
  # |- (0) --> d (-1) --> e (0) --> a
  def set_actions

    @a_to_b = Action.create_with_default_name(@a, @b, lambda{1})
    @a_to_d = Action.create_with_default_name_and_cost(@a, @d)
    @b_to_c = Action.create_with_default_name(@b, @c, lambda{2})
    @d_to_e = Action.create_with_default_name(@d, @e, lambda{1})
    @c_to_c = Action.create_with_default_name(@c, @c, lambda{1})
    @e_to_e = Action.create_with_default_name(@e, @e, lambda{1})
    @c_to_a = Action.create_with_default_name_and_cost(@c, @a)
    @e_to_a = Action.create_with_default_name_and_cost(@e, @a)

    @state_machine << @a_to_b << @a_to_d << @b_to_c << @d_to_e << @c_to_a << @e_to_a << @c_to_c << @e_to_e

  end

end

