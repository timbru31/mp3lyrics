# Fetches the lyrics from AZLyrics.com
# Lyrics are stored accessed via the URL schema http://www.azlyrics.com/lyrics/ARTIST/SONG.html
# They are inside /html/body/div[3]/div/div[2]/div[6], sadly no class to access.
# There are hidden comments, that needs to be removed.
class AZLyrics < Wiki
  def get_lyrics(artist, song)
    artist.delete!(' ')
    song.delete!(' ')

    res = fetch("http://www.azlyrics.com/lyrics/#{artist.downcase}/#{song.downcase}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('/html/body/div[3]/div/div[2]/div[6]')

    lyrics.search('.//comment()').remove

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\n").sub!("\r\r", '')
  end
end
