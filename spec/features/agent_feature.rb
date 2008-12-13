$:.unshift("/usr/local/ruby-1.8.6/lib/ruby/gems/1.8/gems/cucumber-0.1.11/lib")
require 'cucumber/cli' # Needed in order to run the feature with ruby

Feature %|Agent
  In order to decide on my next action
  As an agent
  I want to receive relevant information from the Environment| do

  Scenario "Current State" do
    Given "I am interacting with an Environment"
    When "I enter a new state"
    Then "I should be given information about that state"
  end
  
end
