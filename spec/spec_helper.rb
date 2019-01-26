require 'simplecov'
require 'coveralls'
require 'minitest/autorun'

if ENV['APPVEYOR'] != 'true' && ENV['CIRCLECI'] != 'true'
  SimpleCov.formatters = [Coveralls::SimpleCov::Formatter]
end

SimpleCov.start
