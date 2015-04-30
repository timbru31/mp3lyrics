#!/usr/bin/env ruby
require 'mp3info'
require 'require_all'

require './util/mp3lyrics_util'
require_all './wiki_api/'

override = false
dir = nil

case ARGV.length
when 1
  dir = ARGV[0]
when 2
  override = true
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

files = Dir.glob("#{dir}/**/*")
files.each do |file|
  filename = File.extname(file)
  next unless filename == '.mp3'
  Mp3Info.open(file) do |mp3|
    artist = mp3.tag.artist
    title = mp3.tag.title
    puts "Fetching lyrics for #{artist} - #{title}"
    if !mp3.hastag2? || (mp3.hastag2? && !mp3.tag2.key?('USLT')) || (mp3.hastag2? && override && mp3.tag2.key?('USLT'))
      lyrics = LyricWikia.get_lyrics(artist, title)
      lyrics = MetroLyrics.get_lyrics(artist, title) if lyrics.nil?
      lyrics = AZLyrics.get_lyrics(artist, title) if lyrics.nil?
      lyrics = SwiftLyrics.get_lyrics(artist, title) if lyrics.nil?
      if lyrics.nil?
        puts "Did not find any lyrics\n\r"
      else
        puts "Lyrics found\n\r"
        set_lyrics(file, lyrics)
      end
    end
  end
end
