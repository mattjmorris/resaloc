
class RewardFunctionFactory

  # This function delivers a reward if a specified number of responses since the last reward have occurred.
  # If the number of responses have not occurred, 0 is returned
  def self.fixed_response_function(response_requirement, reward_amount)

    response_count = 0

    lambda do

      response_count += 1
      
      if response_count >= response_requirement
        response_count = 0
        return reward_amount
      else
        return 0
      end

    end

  end

  # This function delivers a reward if a specified number of responses since the last reward has occurred.  The number of
  # responses required is a value randomly selected from a range of values whose median is the avg_response_requirement.
  def self.random_response_function(avg_response_requirement, reward_amount)

    response_count = 0
    response_requirement = get_random_requirement_amount(avg_response_requirement)

    lambda do

      response_count += 1

      if response_count >= response_requirement
        response_count = 0
        response_requirement = get_random_requirement_amount(avg_response_requirement)
        return reward_amount
      else
        return 0
      end

    end

  end

  # This function delivers a reward when a specified fixed amount of time since the last reward has passed.
  # If the amount of time has not passed, 0 is returned
  # NOTE the assumption that tick_count will start at 1
  def self.fixed_time_function(time_requirement, reward_amount)

    last_time = 0

    lambda do |tick_count|

      if tick_count - last_time >= time_requirement
        last_time = tick_count
        return reward_amount
      else
        return 0
      end

    end

  end

  # This function delivers a reward when enough time has passed since the last reward was delivered, and returns 0 all other times.
  # The amount of time required is a value randomly selected from a range of values whose median is the avg_time_requirement.
  # NOTE: it is assumed that tick_count will start at 1
  def self.random_time_function(avg_time_requirement, reward_amount)

    last_time = 0
    time_requirement = get_random_requirement_amount(avg_time_requirement)

    lambda do |tick_count|

      if tick_count - last_time >= time_requirement
        last_time = tick_count
        time_requirement = get_random_requirement_amount(avg_time_requirement)
        return reward_amount
      else
        return 0
      end

    end

  end

  private

  # Returns a random value in the range: avg_requirement +/- (avg_requirement - 1)
  # For example, an avg_requirement of 3 produces a range of (1..5), an avg_requirement of 4 produces the range (1..7)
  def self.get_random_requirement_amount(avg_requirement)
    1 + rand(avg_requirement + (avg_requirement - 1))
  end
  
end
