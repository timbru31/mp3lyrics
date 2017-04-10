require 'simplecov'
require 'coveralls'
require 'minitest/autorun'

if ENV['TRAVIS'] != 'true' && ENV['CIRCLECI'] != 'true'
  SimpleCov.formatters = [Coveralls::SimpleCov::Formatter]
end

SimpleCov.start
