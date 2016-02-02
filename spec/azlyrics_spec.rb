require_relative './spec_helper'
require_relative '../lib/azlyrics'

rise_against_lyrics = "He said \"Son, have you seen the world?\r\rWell, what would you say if I "\
  "said that you could?\r\rJust carry this gun and you'll even get paid.\"\r\rI said \"That "\
  "sounds pretty good.\"\r\r\r\rBlack leather boots\r\rSpit-shined so bright\r\rThey cut off my "\
  "hair but it looked alright\r\rWe marched and we sang\r\rWe all became friends\r\rAs we "\
  "learned how to fight\r\r\r\rA hero of war\r\rYeah that's what I'll be\r\rAnd when I come home"\
  "\r\rThey'll be damn proud of me\r\rI'll carry this flag\r\rTo the grave if I must\r\rBecause "\
  "it's a flag that I love\r\rAnd a flag that I trust\r\r\r\rI kicked in the door\r\rI yelled my "\
  "commands\r\rThe children, they cried\r\rBut I got my man\r\rWe took him away\r\rA bag over "\
  "his face\r\rFrom his family and his friends\r\r\r\rThey took off his clothes\r\rThey pissed "\
  "in his hands\r\rI told them to stop\r\rBut then I joined in\r\rWe beat him with guns\r\rAnd "\
  "batons not just once\r\rBut again and again\r\r\r\rA hero of war\r\rYeah that's what I'll be"\
  "\r\rAnd when I come home\r\rThey'll be damn proud of me\r\rI'll carry this flag\r\rTo the "\
  "grave if I must\r\rBecause it's a flag that I love\r\rAnd a flag that I trust\r\r\r\rShe "\
  "walked through bullets and haze\r\rI asked her to stop\r\rI begged her to stay\r\rBut she "\
  "pressed on\r\rSo I lifted my gun\r\rAnd I fired away\r\r\r\rThe shells jumped through the "\
  "smoke\r\rAnd into the sand\r\rThat the blood now had soaked\r\rShe collapsed with a flag in "\
  "her hand\r\rA flag white as snow\r\r\r\rA hero of war\r\rIs that what they see\r\rJust medals "\
  "and scars\r\rSo damn proud of me\r\rAnd I brought home that flag\r\rNow it gathers dust\r\r"\
  "But it's a flag that I love\r\rIt's the only flag I trust\r\r\r\rHe said, \"Son, have you "\
  "seen the world? \r\rWell what would you say, if I said that you could?\""

describe AZLyrics, 'Lyrics fetching' do
  before do
    @wiki = AZLyrics.new
  end

  describe 'with the song Rise Against - Hero of War' do
    it 'fetches the right lyrics from AZLyrics' do
      lyrics = @wiki.get_lyrics('Rise Against', 'Hero of War')
      lyrics.must_equal rise_against_lyrics
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song')
      lyrics.must_equal nil
    end
  end
end
