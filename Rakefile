require "bundler/gem_tasks"
require "rspec/core/rake_task"
ENV['CODECLIMATE_REPO_TOKEN'] = "cd9a49655127c33503a836a8a8a94803ef897ff0f6d28da43638b698876e21a6"
ENV['MALTCH_TEST'] = "true"
RSpec::Core::RakeTask.new("spec")
task :default => :spec
