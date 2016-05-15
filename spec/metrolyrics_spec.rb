require_relative './spec_helper'
require_relative '../lib/metrolyrics'

breaking_benjamin_lyrics = "Hold it together, birds of a feather\rNothing but lies and crooked "\
  "wings\rI have the answer spreading the cancer\rYou are the faith inside me\rNo, don't leave me "\
  "to die here\rHelp me survive here alone\rNo, don't remember, remember\rPut me to sleep, evil "\
  "angel\rOpen your wings, evil angel\rI'm a believer, nothing could be worse\rAll these imaginary "\
  "friends\rHiding betrayal, driving the nail\rHoping to find a savior\rNo, don't leave me to die "\
  "here\rHelp me survive here alone\rDon't surrender, surrender\rPut me to sleep, evil angel\r"\
  "Open your wings, evil angel\rFly over me, evil angel\rWhy can't I breathe, evil angel?\rPut me "\
  "to sleep, evil angel\rOpen your wings, evil angel\rFly over me, evil angel\rWhy can't I "\
  'breathe, evil angel?'

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
