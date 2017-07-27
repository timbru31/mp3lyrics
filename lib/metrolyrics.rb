require_relative './wiki'

# Fetches the lyrics from MetroLyrics
# Lyrics are stored accessed via the URL schema http://lyrics.wikia.com/ARTIST:SONG
# They are inside //div[@class="lyricbox"], a div with the class "lyricbox"
# There are hidden comments and script tags, that needs to be removed.
class MetroLyrics < Wiki
  def get_lyrics(artist, song, limit = 10)
    artist = artist.tr(' ', '-').parameterize
    song = song.tr(' ', '-').parameterize

    res = fetch("http://www.metrolyrics.com/#{song.downcase}-lyrics-#{artist.downcase}.html", limit)
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//*[@id="lyrics-body-text"]')
    lyrics.search('.driver-photos').remove
    lyrics.search('.driver-related').remove
    prettify_lyrics(lyrics.inner_html)
  end

  def prettify_lyrics(lyrics)
    lyrics = lyrics.gsub('<br>', "\r")
    lyrics = lyrics.gsub("</p>\n<p class=\"verse\">", "\r")
    lyrics = lyrics.gsub(%r{</?[^>]+>}, '')
    lyrics = lyrics.delete("\t")
    lyrics = lyrics.delete("\n")
  end
end
