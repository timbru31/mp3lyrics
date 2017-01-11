require_relative './wiki'

# Fetches the lyrics from Genius (formerly known as Rap Genius)
# Lyrics are stored accessed via the URL schema https://genius.com/ARTIST-SONG-lyrics
# They are inside //lyircs[@class="lyrics"]//p[1], a lyrics element with the class "lyrics"
# It seems that this element was added by Anglar.js
# Inside the p in the lyrics div they are in a tags
class Genius < Wiki
  def get_lyrics(artist, song)
    artist = artist.tr(' ', '-')
    song = song.tr(' ', '-')

    res = fetch("https://genius.com/#{artist.downcase}-#{song.downcase}-lyrics", 10)
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//lyrics[@class="lyrics"]//p[1]')
    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\n")
  end
end
