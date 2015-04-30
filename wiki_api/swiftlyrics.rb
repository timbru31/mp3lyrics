require './util/mp3lyrics_util'
require 'nokogiri'
require 'pry'

class SwiftLyrics
  def self.get_lyrics(artist, song)
    artist.gsub!(' ', '-')
    song.gsub!(' ', '-')

    res = fetch("http://swiftlyrics.com/lyrics/#{artist.downcase}-#{song.downcase}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="left_box_lyrics"]//p[1]')

    lyrics.inner_html.gsub!('<br>', "\r").gsub!("\n", '')
  end
end
