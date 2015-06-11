class LyricWikia < Wiki
  def get_lyrics(artist, song)
    artist.gsub!(' ', '%20')
    song.gsub!(' ', '%20')

    res = fetch("http://lyrics.wikia.com/#{artist}:#{song}")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('//div[@class="lyricbox"]')

    lyrics.search('//script').remove
    lyrics.search('.//comment()').remove

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').gsub!("\n", '')
  end
end
