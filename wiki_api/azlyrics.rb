class AZLyrics < Wiki
  def get_lyrics(artist, song)
    artist.delete!(' ').downcase!
    song.delete!(' ').downcase!

    res = fetch("http://azlyrics.com/lyrics/#{artist}/#{song}.html")
    return nil unless res.is_a? Net::HTTPSuccess

    lyrics = Nokogiri::HTML(res.body).xpath('/html/body/div[3]/div/div[2]/div[6]')

    lyrics.search('.//comment()').remove

    lyrics.inner_html.gsub!('<br>', "\r").gsub!(%r{</?[^>]+>}, '').delete!("\n").sub!("\r\r", '')
  end
end
