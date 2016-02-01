# Fetches the lyrics from SwiftLyrics
# Lyrics are stored accessed via the URL schema http://swiftlyrics.com/lyrics/ARTIST-SONG.html
# They are inside //div[@class="left_box_lyrics"]//p, p tags in the div with the class "left_box_lyrics"
require 'Wiki'

class SwiftLyrics < Wiki
  def get_lyrics(artist, song)
    artist.tr!(' ', '-')
    song.tr!(' ', '-')

    res = fetch("http://swiftlyrics.com/lyrics/#{artist.downcase}-#{song.downcase}.html")

    return nil unless res.is_a? Net::HTTPSuccess
    return nil unless lyrics_available?(res.body)
    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="left_box_lyrics"]//p')

    lyrics.inner_html.gsub!('<br>', "\r").delete!("\n")
  end

  def lyrics_available?(body)
    return Nokogiri::HTML(body).xpath('//div[@class="left_box"]//center').empty?
  end
end
