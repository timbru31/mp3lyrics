# frozen_string_literal: true

require_relative './wiki'

# Fetches the lyrics from LyricWiki
# Lyrics are stored accessed via the URL schema https://lyrics.fandom.com/wiki/ARTIST:SONG
# They are inside //div[@class="lyricbox"], a div with the class "lyricbox"
# There are hidden comments and script tags, that needs to be removed.
class LyricWiki < Wiki
  def get_lyrics(artist, song, limit = 10)
    artist = artist.tr(' ', '_')
    song = song.tr(' ', '_')

    res = fetch("https://lyrics.fandom.com/wiki/#{artist}:#{song}", limit)
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="lyricbox"]')
    prettify_lyrics(lyrics)
  end

  def prettify_lyrics(lyrics)
    lyrics.search('//script').remove
    lyrics.search('.//comment()').remove
    lyrics.inner_html.gsub('<br>', "\r").gsub(%r{</?[^>]+>}, '').delete("\n")
  end
end
