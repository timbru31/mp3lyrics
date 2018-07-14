require_relative './spec_helper'
require_relative '../lib/genius'

numb_lyrics = "[Verse 1: Chester Bennington]\rI'm tired of being what you want me to be\rFeeling so faithless\rLost under the surface\r" \
  "Don't know what you're expecting of me\rPut under the pressure\rOf walking in your shoes\r\r[Pre-Chorus 1: Chester Bennington &amp; " \
  "Mike Shinoda]\rCaught in the undertow\rJust caught in the undertow\rEvery step that I take is\rAnother mistake to you\rCaught in the " \
  "undertow\rJust caught in the undertow\r\r[Chorus: Chester Bennington]\rI've\rBecome so numb\rI can't feel you there\rBecome so tired" \
  "\rSo much more aware\rI'm becoming this\rAll I want to do\rIs be more like me\rAnd be less like you!\r\r[Verse 2: Chester Bennington]" \
  "\rCan't you see that you're smothering me?\rHolding too tightly\rAfraid to lose control\r'Cause everything that you thought I would be" \
  "\rHas fallen apart, right in front of you\r\r[Pre-Chorus 2: Chester Bennington &amp; Mike Shinoda]\rCaught in the undertow\rJust " \
  "caught in the undertow\rEvery step that I take is\rAnother mistake to you\rCaught in the undertow\rJust caught in the undertow\rAnd " \
  "every second I waste is more than I can take!\r\r[Chorus: Chester Bennington]\rI've\rBecome so numb\rI can't feel you there\rBecome so" \
  " tired\rSo much more aware\rI'm becoming this\rAll I want to do\rIs be more like me\rAnd be less like you!\r\r[Bridge: Chester " \
  "Bennington]\rAnd I know\rI may end up failing, too\rBut I know\rYou were just like me\rWith someone disappointed in you\r\r[Chorus: " \
  "Chester Bennington]\rI've\rBecome so numb\rI can't feel you there\rBecome so tired\rSo much more aware\rI'm becoming this\rAll I want" \
  " to do\rIs be more like me\rAnd be less like you!\r\r[Outro: Chester Bennington]\rI've\rBecome so numb\r(I can't feel you there)\rI'm" \
  " tired of being what you want me to be\rI've\rBecome so numb\r(I can't feel you there)\rI'm tired of being what you want me to be"

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
      assert_nil lyrics
    end
  end
end
