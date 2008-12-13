# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'state'

describe State do

  it "should be initialized with a name and a reward amount" do
    s1 = State.new("state_one", 10)
    s1.name.should == "state_one"
    s1.reward.should == 10
  end

  it "should automatically create an id for itself" do
    s1 = State.new("state_one", 10)
    s1.id.nil?.should == false
  end

end

