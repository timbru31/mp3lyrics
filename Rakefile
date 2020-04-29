# frozen_string_literal: true

require 'rake/testtask'
require 'json'

Rake::TestTask.new do |test|
  test.test_files = Dir.glob('test/**/*_spec.rb')
end

Rake::Task['test'].enhance do
  # Temporary hack to get CodeClimate to work with SimpleCov 0.18 JSON format until issue is fixed
  # upstream: https://github.com/codeclimate/test-reporter/issues/413
  if ENV['CI'] == 'true'
    def remove_lines_key(obj)
      case obj
      when Hash
        obj.transform_values do |val|
          val.is_a?(Hash) && val.key?('lines') ? val['lines'] : remove_lines_key(val)
        end
      else
        obj
      end
    end

    puts 'Patching .resultset.json for CodeClimate compatibility'
    filename = 'coverage/.resultset.json'
    contents = JSON.parse(File.read(filename))
    # overwrite
    File.write(filename, JSON.generate(remove_lines_key(contents)))
  end
end

task(default: :test)
