require 'rspec/core/rake_task'

task default: %w[test]

task :test do
  RSpec::Core::RakeTask.new(:spec)
  Rake::Task["spec"].execute
end
