class MetroLyrics < Wiki
  def get_lyrics(artist, song)
    artist.tr!(' ', '-').downcase!
    song.tr!(' ', '-').downcase!

    res = fetch("http://metrolyrics.com/#{song}-lyrics-#{artist}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//*[@id="lyrics-body-text"]')

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\n")
  end
end
