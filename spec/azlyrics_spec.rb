require_relative './spec_helper'
require_relative '../lib/azlyrics'

rise_against_lyrics = "He said \"Son, have you seen the world?\rWell, what would you say if I "\
  "said that you could?\rJust carry this gun and you'll even get paid\"\rI said \"That "\
  "sounds pretty good\"\r\rBlack leather boots\rSpit-shined so bright\rThey cut off my "\
  "hair but it looks alright\rWe marched and we sang\rWe all became friends\rAs we "\
  "learned how to fight\r\rA hero of war\rYeah that's what I'll be\rAnd when I come home"\
  "\rThey'll be damn proud of me\rI'll carry this flag\rTo the grave if I must\rBecause "\
  "it's a flag that I love\rAnd a flag that I trust\r\rI kicked in the door\rI yelled my "\
  "commands\rThe children, they cried\rBut I got my man\rWe took him away\rA bag over "\
  "his face\rFrom his family and his friends\r\rThey took off his clothes\rThey pissed "\
  "in his hands\rI told them to stop\rBut then I joined in\rWe beat him with guns\rAnd "\
  "batons not just once\rBut again and again\r\rA hero of war\rYeah that's what I'll be"\
  "\rAnd when I come home\rThey'll be damn proud of me\rI'll carry this flag\rTo the "\
  "grave if I must\rBecause it's a flag that I love\rAnd a flag that I trust\r\rShe "\
  "walked through bullets and haze\rI asked her to stop\rI begged her to stay\rBut she "\
  "pressed on\rSo I lifted my gun\rAnd I fired away\r\rAnd the shells jumped through the "\
  "smoke\rAnd into the sand\rThat the blood now had soaked\rShe collapsed with a flag in "\
  "her hand\rA flag white as snow\r\rA hero of war\rIs that what they see\rJust medals "\
  "and scars\rSo damn proud of me\rAnd I brought home that flag\rNow it gathers dust\r"\
  "But it's a flag that I love\rIt's the only flag I trust\r\rHe said, \"Son, have you "\
  "seen the world?\rWell what would you say, if I said that you could?\""

describe AZLyrics, 'Lyrics fetching' do
  before do
    @wiki = AZLyrics.new
  end

  describe 'with the song Rise Against - Hero of War' do
    it 'fetches the right lyrics from AZLyrics' do
      lyrics = @wiki.get_lyrics('Rise Against', 'Hero of War', 20)
      _(lyrics).must_equal rise_against_lyrics
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song', 20)
      assert_nil lyrics
    end
  end
end
