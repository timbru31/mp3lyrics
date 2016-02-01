require 'minitest/autorun'
require 'Genius'

numb_lyrics = "[Verse 1]\rI'm tired of being what you want me to be\rFeeling so faithless, lost under the surface\rDon't know what you're expecting of me\r"\
  "Put under the pressure of walking in your shoes\r(Caught in the undertow, just caught in the undertow)\rEvery step that I take is another mistake to you\r"\
  "(Caught in the undertow, just caught in the undertow)\r\r[Hook]\rI've become so numb, I can't feel you there\rBecome so tired, so much more aware\r"\
  "I'm becoming this, all I want to do\rIs be more like me and be less like you\r\r[Verse 2]\rCan't you see that you're smothering me\r"\
  "Holding too tightly, afraid to lose control?\rCause everything that you thought I would be\rHas fallen apart right in front of you\r"\
  "(Caught in the undertow, just caught in the undertow)\rEvery step that I take is another mistake to you\r"\
  "(Caught in the undertow, just caught in the undertow)\rAnd every second I waste is more than I can take\r\r[Bridge]\r"\
  "And I know I may end up failing too\rBut I know you were just like me with someone disappointed in you\r\r[Hook]\r"\
  "I've become so numb, I can't feel you there\rBecome so tired, so much more aware\rI'm becoming this, all I want to do\r"\
  "Is be more like me and be less like you\r\r[Hook]\rI've become so numb, I can't feel you there\r(I'm tired of being what you want me to be)\r"\
  "I've become so numb, I can't feel you there\r(I'm tired of being what you want me to be)"

describe Genius, 'Lyrics fetching' do
  before do
    @wiki = Genius.new
  end

  describe 'with the song Linkin Park - Numb' do
    it 'fetches the right lyrics from Genius' do
      lyrics = @wiki.get_lyrics('Linkin Park', 'Numb')
      lyrics.must_equal numb_lyrics
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song')
      lyrics.must_equal nil
    end
  end
end
