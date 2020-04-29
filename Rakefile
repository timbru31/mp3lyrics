# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |test|
  test.test_files = Dir.glob('test/**/*_spec.rb')
end

task(default: :test)
