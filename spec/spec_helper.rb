require 'codeclimate-test-reporter'
require 'coveralls'
require 'minitest/autorun'

# Coveralls.wear!
# CodeClimate::TestReporter.start

SimpleCov.formatters = [
  Coveralls::SimpleCov::Formatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start
