require 'minitest/autorun'
require './wiki_api/Wiki'
require './wiki_api/MetroLyrics'

breaking_benjamin_lyrics = "Hold it together, birds of a feather\rNothing but lies and crooked wings\rI have the answer spreading the cancer\r"\
  "You are the faith inside meNo, don't leave me to die here\rHelp me survive here alone\rNo, don't remember, rememberPut me to sleep, evil angel\r"\
  "Open your wings, evil angelI'm a believer, nothing could be worse\rAll these imaginary friends\rHiding betrayal, driving the nail\r"\
  "Hoping to find a saviorNo, don't leave me to die here\rHelp me survive here alone\rDon't surrender, surrenderPut me to sleep, evil angel\r"\
  "Open your wings, evil angel\rFly over me, evil angel\rWhy can't I breathe, evil angel?Put me to sleep, evil angel\rOpen your wings, evil angel\r"\
  "Fly over me, evil angel\rWhy can't I breathe, evil angel?\t"

describe MetroLyrics, 'Lyrics fetching' do
  before do
    @wiki = MetroLyrics.new
  end

  describe 'with the song Breaking Benjamin - Evil Angel' do
    it 'fetches the right lyrics from MetroLyrics' do
      lyrics = @wiki.get_lyrics('Breaking Benjamin', 'Evil Angel')
      lyrics.must_equal breaking_benjamin_lyrics
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song')
      lyrics.must_equal nil
    end
  end
end
