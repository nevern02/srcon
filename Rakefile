require "bundler/gem_tasks"
require "rspec/core/rake_task"

$LOAD_PATH << File.expand_path('../lib/srcon', __FILE__)

RSpec::Core::RakeTask.new(:spec)

task :console do
  require 'srcon'
  require 'pry'
  binding.pry
end

task :default => :spec
