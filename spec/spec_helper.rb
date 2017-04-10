require 'simplecov'
require 'coveralls'
require 'minitest/autorun'

# Coveralls.wear!
# CodeClimate::TestReporter.start

SimpleCov.formatters = [Coveralls::SimpleCov::Formatter] unless ENV['TRAVIS'] == 'true'
SimpleCov.start
