require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |test|
  test.test_files = Dir.glob('spec/**/*_spec.rb')
  test.verbose = false
  test.warning = false
end

task(default: :test)
