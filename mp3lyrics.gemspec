# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'mp3lyrics'
  s.version = '0.2.0'
  s.date = '2021-08-16'
  s.summary = 'CLI for mp3 lyrics fetching'
  s.description = 'CLI for mp3 lyrics fetching. Uses ruby-mp3info and fetches different lyric wikis'
  s.authors = ['Tim Brust']
  s.email = 'github@timbrust.de'
  s.files = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.homepage = 'https://github.com/timbru31/'
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.6.0'
  s.executables << 'mp3lyrics'

  if s.respond_to?(:metadata=)
    s.metadata = {
      'bug_tracker_uri' => 'https://github.com/timbru31/mp3lyrics/issues?q=is%3Aopen+is%3Aissue',
      'changelog_uri' => 'https://github.com/timbru31/mp3lyrics/blob/master/CHANGELOG.md',
      'source_code_uri' => 'https://github.com/timbru31/mp3lyrics/'
    }
  end
end
