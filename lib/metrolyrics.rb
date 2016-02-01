# Fetches the lyrics from MetroLyrics
# Lyrics are stored accessed via the URL schema http://lyrics.wikia.com/ARTIST:SONG
# They are inside //div[@class="lyricbox"], a div with the class "lyricbox"
# There are hidden comments and script tags, that needs to be removed.
require 'Wiki'

class MetroLyrics < Wiki
  def get_lyrics(artist, song)
    artist.tr!(' ', '-')
    song.tr!(' ', '-')

    res = fetch("http://www.metrolyrics.com/#{song.downcase}-lyrics-#{artist.downcase}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//*[@id="lyrics-body-text"]')

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\n")
  end
end
