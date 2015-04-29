#!/usr/bin/env ruby
require 'mp3info'
require 'net/http'
require 'nokogiri'

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
dir is #{dir}
override is #{override}\n"

def fetch(uri_str, limit = 10)
  # You should choose better exception.
  fail ArgumentError, 'HTTP redirect too deep' if limit == 0

  url = URI.parse(uri_str)
  req = Net::HTTP::Get.new(url.path)
  response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  case response
  when Net::HTTPSuccess     then response
  when Net::HTTPRedirection then fetch(response['location'], limit - 1)
  else
    response.error!
  end
end

def get_lyrics(artist, song)
  artist.gsub!(' ', '%20')
  song.gsub!(' ', '%20')

  res = fetch("http://lyrics.wikia.com/#{artist}:#{song}")

  lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="lyricbox"]')

  lyrics.search('//script').remove
  lyrics.search('.//comment()').remove

  lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').gsub!("\n", '')
end

def set_lyrics(file, lyrics)
  Mp3Info.open(file) do |mp3|
    mp3.tag2.USLT = lyrics
  end
end

files = Dir.glob("#{dir}/**/*")
files.each do |file|
  filename = File.extname(file)
  next unless filename == '.mp3'
  Mp3Info.open(file) do |mp3|
    artist = mp3.tag.artist
    title = mp3.tag.title
    if !mp3.hastag2? || (mp3.hastag2? && !mp3.tag2.key?('USLT'))
      lyrics = get_lyrics(artist, title)
      set_lyrics(file, lyrics)
    elsif mp3.hastag2? && override && mp3.tag2.key?('USLT')
      lyrics = get_lyrics(artist, title)
      set_lyrics(file, lyrics)
    end
  end
end
