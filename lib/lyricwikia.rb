require_relative './wiki'

# Fetches the lyrics from LyricWikia
# Lyrics are stored accessed via the URL schema http://lyrics.wikia.com/ARTIST:SONG
# They are inside //div[@class="lyricbox"], a div with the class "lyricbox"
# There are hidden comments and script tags, that needs to be removed.
class LyricWikia < Wiki
  def get_lyrics(artist, song)
    artist = artist.tr(' ', '_')
    song = song.tr(' ', '_')

    res = fetch("http://lyrics.wikia.com/#{artist}:#{song}")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="lyricbox"]')
    prettify_lyrics(lyrics)
  end

  def prettify_lyrics(lyrics)
    lyrics.search('//script').remove
    lyrics.search('.//comment()').remove
    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\n")
  end
end
