require './util/mp3lyrics_util'
require 'nokogiri'

class MetroLyrics
  def self.get_lyrics(artist, song)
    artist.gsub!(' ', '-')
    song.gsub!(' ', '-')

    res = fetch("http://metrolyrics.com/#{song.downcase}-lyrics-#{artist.downcase}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//*[@id="lyrics-body-text"]')

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').gsub!("\n", '')
  end
end
