
require File.dirname(__FILE__) + '/../lib/state'
require File.dirname(__FILE__) + '/../lib/action'

describe State do

  before(:each) do
    @s1 = State.new("state_one", lambda{0})
  end

  it "should be initialized with a name and a reward function" do
    s1 = State.new("state_one", lambda{10})
    s1.name.should == "state_one"
    s1.get_reward.should == 10
  end

  it "should have a constructor that defaults to a reward function that always returns zero" do
    s1 = State.create_with_default_reward("state one")
    s1.get_reward.should == 0
  end

  it "should automatically create an id for itself" do
    @s1.id.nil?.should == false
  end
  
  it "should allow the reward function to be changed at any time" do
    @s1.get_reward.should == 0
    @s1.reward_function = lambda{10}
    @s1.get_reward.should == 10
  end

  it "should use an optional tick_count parameter when calculating reward" do
    @s1.get_reward(1).should == 0
    @s1.reward_function = lambda{|tick_count| return tick_count * 2}
    @s1.get_reward(1).should == 2
  end

end

