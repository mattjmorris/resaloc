# A resource that may be consumed

class Resource
  
  # The range of values that may be delivered by this resource 
  # For example: (-10..10) or (20..50)
  attr_accessor :value_range
      
  # The cost of acquiring this resource.  For example, you may have to
  # pay $1 to gain access to respond on a resource.
  attr_accessor :cost_of_acquisition

  # The cost of making a response on this resource.  For example, a one
  # armed bandit may cost $0.25 for each pull of the lever
  attr_accessor :cost_of_response
  
  def initialize(value_range)
    
    @value_range = value_range
    
    @cost_of_acquisition = 1

    @cost_of_response = 1
    
    @agents = []
    
    @new_agents = []
    
  end
  
  def tick
    
    deliver_cost_to_new_agents(@cost_of_acquisition)
    @new_agents = []
    
    deliver_value_to_agents(random_val_within_range)
    
  end
  
  def register_agent(agent)
    @new_agents << agent
    @agents << agent
  end
  
  private
  
  def deliver_cost_to_new_agents(amount)
    @new_agents.each {|agent| agent.resource_delivery(-amount)}
  end
    
  def deliver_value_to_agents(amount)
    @agents.each {|agent| agent.resource_delivery(amount)}
  end
  
  def random_val_within_range
    magnitude_of_range = @value_range.end - @value_range.begin + 1
    return rand(magnitude_of_range) + @value_range.begin
  end
  
end
