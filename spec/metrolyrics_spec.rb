require_relative './spec_helper'
require_relative '../lib/metrolyrics'

breaking_benjamin_lyrics = "Hold it together, birds of a feather\rNothing but lies and crooked "\
  "wings\rI have the answer, spreading the cancer\rYou are the faith inside me\rNo, don't\rLeave me "\
  "to die here\rHelp me survive here\rAlone, don't remember, remember\rPut me to sleep, evil "\
  "angel\rOpen your wings, evil angel A-ah\rI'm a believer\rNothing could be worse\rAll these imaginary "\
  "friends\rHiding betrayal\rDriving the nail\rHoping to find a savior\rNo, don't\rLeave me to die "\
  "here\rHelp me survive here\rAlone, don't\rSurrender, surrender\rPut me to sleep, evil angel\r"\
  "Open your wings, evil angel\rOh\rFly over me, evil angel\rWhy can't I breathe, evil angel?Put me "\
  "to sleep, evil angel\rOpen your wings, evil angel\rOh\rFly over me, evil angel\rWhy can't I "\
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
      assert_nil lyrics
    end
  end
end
