require './wiki_api/Wiki'
require './wiki_api/LyricWikia'

enter_shikari_lyrics = "Now I don't know about you but I don't think the primary purpose of your life, of my life, of the entirety of the human "\
  "race is just to blindly consume to support a failing economy and a faulty system, forever and ever until we run out of every resource and have to "\
  "resort to blowing each other up to ensure our own survival. I don't think we're supposed to sit by idle whilst we continue to use a long-outdated "\
  "system that produces war, poverty, collusion, corruption, ruins our environment and threatens every aspect of our health, and does nothing but "\
  "divide and segregate us. I don't think how much military equipment we're selling to other countries, how many hydrocarbons we're burning, how much "\
  "money's been printed in exchange, is a good measure of how healthy our society is. But I do think I can speak for everyone when I say:\r\r"\
  "We're sick of this shit!\r\rTime to mobilise,\rTime to open eyes.\r\rWe are not a quiet pocket of resistance (This is real!)\r"\
  "But we cannot afford to fail!\rAct with, act with persistence (This is real!)\rBut we cannot afford to fail!\rArmy, established order,\r"\
  "Respect me and fear me! (Fuck you!)\rWe hold no respect,\rAnd when tomorrow comes,\rWE'RE GONNA STAMP ON YOUR HEAD. PIG.\r\r"\
  "Rory C: Woah, woah! Calm down, calm the fuck down! Jesus.\rRob: Calm down mate! Gandhi mate, remember Gandhi...\rRou: Alright, alright I'm fine.\r\r"\
  "See, if we keep them silent, then they'll resort to violence and that's how we criminalise change.\r\rAhhhhhh, Yabba dabba do one, son!\r"\
  "We don't want your rules!\rWho you foolin', son, we've got all the tools,\rWe need to build a whole new system,\rTo correct these flaws!\r"\
  "(You know what) I've already listed them,\rYou're a Communist!\rYou're a fucking Utopianist!\rAh, here they come, the immersive labels\r"\
  "But they're attempted fails.\r\r'Cause man, we're so far out your comfort zone.\r\rWe stop, think, begin to revive.\r"\
  "We stop, think, begin to revive.\rWe stop, we think, we begin to revive,\rWe begin to revive.\r\rPut a call out to the frontline,\r"\
  "Get the message out to the contact squad.\rTransmit emergency frequencies.\rPut a call out to the frontline,\r"\
  "Get the message out to the contact squad.\rPut a call out, put a call out, put a call OOUUUTT.\r\rOh and the jigsaw starts to build.\r"\
  "Oh and the jigsaw starts to build.\r\rPiece by PIIEECCEE!\r\rOPEN THEIR MINDS.\r\rTransmit emergency frequencies!\r\rOPEN THEIR MINDS.\r\r"\
  "Transmit emergency frequencies!\r\rEmergency frequencies.\rEmergency frequencies.\rEmergency frequencies.\rEmergency frequencies."

RSpec.describe LyricWikia, 'Lyrics fetching' do
  context 'with the song Enter Shikari - Gandhi Mate, Gandhi' do
    it 'fetches the right lyrics from LyricWikia' do
      wiki = LyricWikia.new
      lyrics = wiki.get_lyrics('Enter Shikari', 'Gandhi Mate, Gandhi')
      expect(lyrics).to eq enter_shikari_lyrics
    end
  end
  context 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      wiki = LyricWikia.new
      lyrics = wiki.get_lyrics('Non Existing', 'No Song')
      expect(lyrics).to eq nil
    end
  end
end
