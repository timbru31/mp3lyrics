#!/usr/bin/env ruby
require 'mp3info'
require 'require_all'

require_all './lib/'

def to_b(string)
  !(string =~ /^(true|t|yes|y|1)$/i).nil?
end

override = false
dir = nil

case ARGV.length
when 1
  dir = ARGV[0]
when 2
  override = to_b(ARGV[1])
  dir = ARGV[0]
else
  puts 'Usage: ./mp3lyrics.rb <dir> [override]'
  exit
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
Overriding existing lyrics is #{override}\n\r"

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
      lyrics = LyricWikia.new.get_lyrics(artist, title)
      lyrics = Genius.new.get_lyrics(artist, title) if lyrics.nil?
      lyrics = MetroLyrics.new.get_lyrics(artist, title) if lyrics.nil?
      lyrics = AZLyrics.new.get_lyrics(artist, title) if lyrics.nil?
      lyrics = SwiftLyrics.new.get_lyrics(artist, title) if lyrics.nil?
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
