
 

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

$:.unshift("/usr/local/ruby-1.8.6/lib/ruby/gems/1.8/gems/cucumber-0.1.11/lib")
require 'cucumber/rake/task'

Cucumber::Rake::Task.new do |t|
  puts
  puts "running the rake task, dude"
  t.cucumber_opts = "--format pretty"
end
