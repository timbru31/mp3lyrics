require_relative './wiki'

# Fetches the lyrics from AZLyrics.com
# Lyrics are stored accessed via the URL schema https://www.azlyrics.com/lyrics/ARTIST/SONG.html
# They are inside /html/body/div[2]/div/div[2]/div[5], sadly no class to access.
# There are hidden comments, which need to be removed.
class AZLyrics < Wiki
  def get_lyrics(artist, song, limit = 10)
    artist = artist.delete(' ').parameterize
    song = song.delete(' ').parameterize

    res = fetch("https://www.azlyrics.com/lyrics/#{artist.downcase}/#{song.downcase}.html", limit)
    puts res.code
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('/html/body/div[2]/div/div[2]/div[5]')
    prettify_lyrics(lyrics)
  end

  def prettify_lyrics(lyrics)
    lyrics.search('.//comment()').remove
    lyrics.inner_html.gsub('<br>', "\r").delete("\n").sub("\r\r", '')
  end
end
