class SwiftLyrics < Wiki
  def get_lyrics(artist, song)
    artist.tr!(' ', '-').downcase!
    song.tr!(' ', '-').downcase!

    res = fetch("http://swiftlyrics.com/lyrics/#{artist}-#{song}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="left_box_lyrics"]//p[1]')

    lyrics.inner_html.gsub!('<br>', "\r").delete!("\n")
  end
end
