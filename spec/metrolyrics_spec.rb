require_relative './spec_helper'
require_relative '../lib/metrolyrics'

breaking_benjamin_lyrics = "Hold it together\rBirds of a feather\rNothing but lies and crooked wings\rI have the "\
  "answer\rSpreading the cancer\rYou are the faith inside me\rNo\rDon't leave me to die here\rHelp me survive here "\
  "alone\rDon't remember\rPut me to sleep\rEvil angel\rOpen your wings\rEvil angel\rI'm a believer Nothing could be "\
  "worse\rAll these imaginary friends\rHiding betrayal\rDriving the nail\rHoping to find a savior\rNo\rDon't leave "\
  "me to die here\rHelp me survive here alone\rDon't surrender\rPut me to sleep\rEvil angel\rOpen your wings\rEvil "\
  "angel\rFly over me\rEvil angel\rWhy can't I breathe\rEvil angel\rPut me to sleepEvil angel\rOpen your wings\rEvil "\
  "angel\rFly over me\rEvil angel\rWhy can't I breathe\rEvil angel"

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
