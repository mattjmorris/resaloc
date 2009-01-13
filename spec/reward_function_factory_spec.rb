# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'reward_function_factory'

describe RewardFunctionFactory do

  it "should return a fixed response function" do

    # FR5 w/ reward of 3
    fr5 = RewardFunctionFactory.fixed_response_function(5, 3)
    (1..10).each do |tick_count|
      # tick_count is not required as an argument, and has no effect.  But it is OK to pass it.
      reward = fr5.call(tick_count)
      reward.should == 0 if tick_count % 5 != 0
      reward.should == 3 if tick_count % 5 == 0
    end

    #FR1 w/ reward of 2
    fr1 = RewardFunctionFactory.fixed_response_function(1, 2)
    5.times do
      fr1.call.should == 2
    end

  end

  it "should return a fixed time function" do

    ft10 = RewardFunctionFactory.fixed_time_function(10, 3)
    ft10.call(10).should == 3
    ft10.call(11).should == 0
    ft10.call(19).should == 0
    ft10.call(20).should == 3
    ft10.call(32).should == 3
    ft10.call(41).should == 0
    ft10.call(42).should == 3

  end

  it "should return a random response function" do

    vr5 = RewardFunctionFactory.random_response_function(5, 3)
    response_requirements = []

    # for each 'experiment', see how many times we have to responsd before obtaining the reward
    num_of_experiments = 1000
    num_of_experiments.times do
      num_responses = 0
      max_responses = 30 # we should never have to respond this many times
      max_responses.times do
        num_responses += 1
        if vr5.call == 3
          response_requirements << num_responses
          num_responses = 0
          break
        end
      end
    end

    # number of responses required should have been a flat distribution ranging from 1 to 9.
    response_requirements.find_all{|x| x < 1}.length.should == 0
    response_requirements.find_all{|x| x > 9}.length.should == 0
    (1..9).each do |i|
      (response_requirements.find_all{|x| x == i}.length/response_requirements.length.to_f).should be_close(1.to_f/9, 0.03)
    end
  end

  it "should return a variable time function" do

    vt5 = RewardFunctionFactory.random_time_function(5, 3)
    time_requirements = []

    old_time = 0

    total_ticks = 10000
    total_ticks.times do |num_ticks|
      if vt5.call(num_ticks) == 3
        time_requirements << (num_ticks - old_time)
        old_time = num_ticks
      end
    end

    # number of times required should have been a flat distribution ranging from 1 to 9
    time_requirements.find_all{|x| x < 1}.length.should == 0
    time_requirements.find_all{|x| x > 9}.length.should == 0
    (1..9).each do |i|
      (time_requirements.find_all{|x| x == i}.length/time_requirements.length.to_f).should be_close(1.to_f/9, 0.03)
    end

    # note that tick_count is assumed to start at 1, so 0 won't produce a reward.
    vt1 = RewardFunctionFactory.random_time_function(1, 2)
    vt1.call(0).should == 0
    vt1.call(1).should == 2
    vt1.call(2).should == 2
    vt1.call(4).should == 2

    # should never give reward if elapsed time since last reward is less than the range (which should be 1..3 in this case),
    # but should always give reward if elapsed time since last reward is greater than the range of times
    vt2 = RewardFunctionFactory.random_time_function(2, 3)
    vt2.call(0).should == 0
    vt2.call(4).should == 3
    vt2.call(4).should == 0
    vt2.call(8).should == 3
  end
  
end

