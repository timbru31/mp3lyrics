# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'mp3lyrics'
  s.version     = '0.1.0'
  s.date        = '2010-04-28'
  s.summary     = 'CLI for mp3 lyrics fetching'
  s.description = 'CLI for mp3 lyrics fetching. Uses ruby-mp3info and fetches different lyric wikis'
  s.authors     = ['Tim Brust']
  s.email       = 'github@timbrust.de'
  s.files       = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.homepage    = 'https://github.com/timbru31/'
  s.license     = 'MIT'
  s.executables << 'mp3lyrics'
end
