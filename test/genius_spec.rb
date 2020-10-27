# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/wiki/genius'

lyrics_part1 = "[Verse 1: Chester Bennington]\rI'm tired of being what you want me to be\rFeeling so faithless, lost under the surface" \
  "\rI don't know what you're expecting of me\rPut under the pressure of walking in your shoes\r\r[Pre-Chorus: Chester Bennington &amp; " \
  "Mike Shinoda]\rCaught in the undertow, just caught in the undertow\rEvery step that I take is another mistake to you\rCaught in the " \
  "undertow, just caught in the undertow\r\r[Chorus: Chester Bennington]\rI've become so numb, I can't feel you there\rBecome so tired" \
  ", so much more aware\rI'm becoming this, all I want to do\rIs be more like me and be less like you\r\r[Verse 2: Chester Bennington]" \
  "\rCan't you see that you're smothering me?\rHolding too tightly, afraid to lose control\r'Cause everything that you thought I would be" \
  "\rHas fallen apart, right in front of you\r\r[Pre-Chorus: Chester Bennington &amp; Mike Shinoda]\rCaught in the undertow, just " \
  "caught in the undertow\rEvery step that I take is another mistake to you\rCaught in the undertow, just caught in the undertow\rAnd " \
  'every second I waste is more than I can take'

lyrics_part2 = "[Chorus: Chester Bennington]\rI've become so numb, I can't feel you there\rBecome so" \
  " tired, so much more aware\rI'm becoming this, all I want to do\rIs be more like me and be less like you\r\r[Bridge: Chester " \
  "Bennington]\rAnd I know I may end up failing, too\rBut I know you were just like me\rWith someone disappointed in you\r\r[Chorus: " \
  "Chester Bennington]\rI've become so numb, I can't feel you there\rBecome so tired, so much more aware\rI'm becoming this, all I want" \
  " to do\rIs be more like me and be less like you\r\r[Outro: Chester Bennington]\rI've become so numb, I can't feel you there\rI'm" \
  " tired of being what you want me to be\rI've become so numb, I can't feel you there\rI'm tired of being what you want me to be"

numb_lyrics_variant1 = "#{lyrics_part1}\r#{lyrics_part2}"
numb_lyrics_variant2 = "#{lyrics_part1}\r\r#{lyrics_part2}"

describe Genius, 'Lyrics fetching' do
  before do
    @wiki = Genius.new
  end

  describe 'with the song Linkin Park - Numb' do
    it 'fetches the right lyrics from Genius' do
      lyrics = @wiki.get_lyrics('Linkin Park', 'Numb')
      assert (lyrics.eql? numb_lyrics_variant1) || (lyrics.eql? numb_lyrics_variant2)
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song')
      assert_nil lyrics
    end
  end
end
