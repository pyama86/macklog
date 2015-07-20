require "bundler/gem_tasks"
require "rspec/core/rake_task"
ENV['CODECLIMATE_REPO_TOKEN']="e8ca1bd02a83946d3e1618a57c4cc5fb141c8288d0d246e8e6999c2314350baf"
ENV['MALTCH_TEST'] = "true"
RSpec::Core::RakeTask.new("spec")
task :default => :spec
