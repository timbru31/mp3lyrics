#!/usr/bin/env ruby
require 'mp3info'
require 'require_all'

require_all './lib/'

def to_b(string)
  !(string =~ /^(true|t|yes|y|1)$/i).nil?
end

def usage_message(overide_options, wiki_options)
  'Usage: ./mp3lyrics.rb <dir> [-overide ' + overide_options.join("/") + '] [-wiki ' + wiki_options.join("/") + ']'
end

override = false
wiki_to_use = nil
dir = nil

dir = ARGV[0]
if ARGV.length > 1

  i = 1
  overide_options = ["true", "false"]
  wiki_options = ["lyricwikia", "genius", "metrolyrics", "azlyrics", "swiftlyrics"]

  if ARGV.length % 2 == 0 or ARGV.count(/-overide/) > 1 or ARGV.count(/-wiki/) > 1
    puts usage_message(overide_options, wiki_options)
    exit
  end

  while i < ARGV.length do
    if ARGV[i] == "-overide"
      if overide_options.include?(ARGV[i + 1])
        override = to_b(ARGV[i + 1])
      else
        puts usage_message(overide_options, wiki_options)
        exit
      end
    end
    if ARGV[i] == "-wiki"
      if wiki_options.include?(ARGV[i + 1])
        wiki_to_use = ARGV[i + 1]
      else
        puts usage_message(overide_options, wiki_options)
        exit
      end
    end
    i += 1
  end

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
if wiki_to_use != nil
  puts "Specific wiki to use is #{wiki_to_use}"
end
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
      if wiki_to_use == nil or wiki_to_use == "lyricwikia"
        lyrics = LyricWikia.new.get_lyrics(artist, title)
      end
      if wiki_to_use == nil or wiki_to_use == "genius"
        lyrics = Genius.new.get_lyrics(artist, title) if lyrics.nil?
      end
      if wiki_to_use == nil or wiki_to_use == "metrolyrics"
        lyrics = MetroLyrics.new.get_lyrics(artist, title) if lyrics.nil?
      end
      if wiki_to_use == nil or wiki_to_use == "azlyrics"
        lyrics = AZLyrics.new.get_lyrics(artist, title) if lyrics.nil?
      end
      if wiki_to_use == nil or wiki_to_use == "swiftlyrics"
        lyrics = SwiftLyrics.new.get_lyrics(artist, title) if lyrics.nil?
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
