#!/usr/bin/env ruby
# frozen_string_literal: true

require 'mp3info'
require 'require_all'

require_all './lib/wiki/'

def to_b(string)
  !(string =~ /^(true|t|yes|y|1)$/i).nil?
end

def usage_message(override_options, use_options)
  'Usage: ./mp3lyrics.rb <dir> [-override ' + override_options.join('/') + '] [-use ' + use_options.join('/') + ']'
end

override_options = [true, false]
use_options = %w[genius metrolyrics azlyrics]

if ARGV.length.even? ||
   ARGV.count('-override') > 1 ||
   ARGV.count('-use') > 1
  # If there is an even number of arguments (includes no arguments)
  # or a flag has been used more than once
  puts usage_message(override_options, use_options)
  exit
end

dir = ARGV[0]
override = false
wiki_to_use = nil

i = 1
while i < ARGV.length
  if ARGV[i] == '-override'
    if override_options.include?(to_b(ARGV[i + 1]))
      override = to_b(ARGV[i + 1])
    else
      # If the argument after the override flag is invalid
      puts usage_message(override_options, use_options)
      exit
    end
  elsif ARGV[i] == '-use'
    if use_options.include?(ARGV[i + 1])
      wiki_to_use = ARGV[i + 1]
    else
      # If the argument after the use flag is invalid
      puts usage_message(override_options, use_options)
      exit
    end
  else
    # If the argument is not a valid flag
    puts usage_message(override_options, use_options)
    exit
  end
  i += 2
end

puts "
                  Welcome to
  __  __ _____ ____  _                _
 |  \\\/  |  __ \\___ \\| |              (_)
 | \\  \/ | |__) |__) | |    _   _ _ __ _  ___ ___
 | |\\/| |  ___\/|__ <| |   | | | | \'__| |\/ __\/ __|
 | |  | | |    ___) | |___| |_| | |  | | (__\\__ \\
 |_|  |_|_|   |____\/|______\\__, |_|  |_|\\___|___\/
                            __\/ |
                           |___\/

The current working directory is #{dir}
Overriding existing lyrics is #{override}"
puts "Specific wiki to use is #{wiki_to_use}" unless wiki_to_use.nil?
puts "\n\r"

wiki = Wiki.new
files = Dir.glob("#{dir}/**/*")
files.each do |file|
  filename = File.extname(file)
  next unless filename == '.mp3'

  Mp3Info.open(file) do |mp3|
    artist = mp3.tag.artist || mp3.tag1.artist || mp3.tag2.artist
    title = mp3.tag.title || mp3.tag1.title || mp3.tag2.title
    if artist.nil? || title.nil?
      puts "Skipping song because title or artist is not set...\n\r"
      next
    end
    puts "Fetching lyrics for #{artist} - #{title}"
    # Either no tag is set, the mp3 file has no USLT tag or we override anyway
    if !mp3.hastag2? || (mp3.hastag2? && !mp3.tag2.key?('USLT')) || override
      lyrics = nil
      lyrics = Genius.new.get_lyrics(artist, title) if wiki_to_use.nil? || wiki_to_use == 'genius'
      if wiki_to_use.nil? || wiki_to_use == 'metrolyrics'
        lyrics = MetroLyrics.new.get_lyrics(artist, title) if lyrics.nil?
      end
      if wiki_to_use.nil? || wiki_to_use == 'azlyrics'
        lyrics = AZLyrics.new.get_lyrics(artist, title) if lyrics.nil?
      end
      if lyrics.nil?
        puts "Did not find any lyrics\n\r"
      else
        puts "Lyrics found\n\r"
        wiki.set_lyrics(mp3, lyrics)
      end
    else
      puts "Skipping #{artist} - #{title} because lyrics are already set"
    end
  end
end
