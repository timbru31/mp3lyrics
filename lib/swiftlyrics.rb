require_relative './wiki'

# Fetches the lyrics from SwiftLyrics
# Lyrics are stored accessed via the URL schema http://swiftlyrics.com/lyrics/ARTIST-SONG.html
# They are inside //div[@class="left_box_lyrics"]//p,
# p tags in the div with the class "left_box_lyrics"
class SwiftLyrics < Wiki
  def get_lyrics(artist, song, limit = 10)
    artist = artist.tr(' ', '-')
    song = song.tr(' ', '-')

    res = fetch("http://swiftlyrics.com/lyrics/#{artist.downcase}-#{song.downcase}.html", limit)

    return nil unless res.is_a? Net::HTTPSuccess
    return nil unless lyrics_available?(res.body)
    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="left_box_lyrics"]')
    prettify_lyrics(lyrics)
  end

  def prettify_lyrics(lyrics)
    lyrics.css('script').remove
    lyrics.css('a').remove
    lyrics.css('h1').remove
    lyrics.css('div').remove
    lyrics.inner_html.gsub!('<br>', "\r").gsub!('</p>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\t").delete!("\n")
  end

  def lyrics_available?(body)
    Nokogiri::HTML(body).xpath('//div[@class="left_box"]//center').empty?
  end
end
