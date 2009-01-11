
class RewardFunctionFactory

  # This function delivers a reward if a specified fixed amount of time since the last reward has passed.
  # If the amount of time has not passed, 0 is returned
  def self.fixed_time_function(time_requirement, reward_amount)

    @last_time = -1

    lambda do |tick_count|

      if tick_count - @last_time >= time_requirement
        @last_time = tick_count
        return reward_amount
      else
        return 0
      end

    end

  end

  # This function delivers a reward if a specified number of responses since the last reward have occurred.
  # If the number of responses have not occurred, 0 is returned
  def self.fixed_response_function(response_requirement, reward_amount)

    @response_count = 0

    lambda do

      if @response_count >= response_requirement
        @response_count = 0
        return reward_amount
      else
        return 0
      end

    end

  end
end
