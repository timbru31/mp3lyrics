require './util/mp3lyrics_util'
require 'nokogiri'

class AZLyrics
  def self.get_lyrics(artist, song)
    artist.gsub!(' ', '')
    song.gsub!(' ', '')

    res = fetch("http://azlyrics.com/lyrics/#{artist.downcase}/#{song.downcase}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('/html/body/div[3]/div/div[2]/div[6]')

    lyrics.search('.//comment()').remove

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').gsub!("\n", '').sub!("\r\r", '')
  end
end
