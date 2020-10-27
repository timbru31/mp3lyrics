# frozen_string_literal: true

require_relative './wiki'

# Fetches the lyrics from Genius (formerly known as Rap Genius)
# Lyrics are stored accessed via the URL schema https://genius.com/ARTIST-SONG-lyrics
# They are inside //div[starts-with(@class, "Lyrics__Container")]
class Genius < Wiki
  def get_lyrics(artist, song, limit = 10)
    artist = artist.tr(' ', '-').parameterize
    song = song.tr(' ', '-').parameterize

    res = fetch("https://genius.com/#{artist.downcase}-#{song.downcase}-lyrics", limit)
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath("//div[starts-with(@class, 'lyrics') or starts-with(@class, 'Lyrics__Container')]")
    lyrics.inner_html.gsub('<br>', "\r").gsub(%r{</?[^>]+>}, '').delete("\n").strip
  end
end
