# frozen_string_literal: true

require_relative './spec_helper'
require_relative '../lib/wiki/lyricwiki'

enter_shikari_lyrics = "Now, I don't know about you, but I don't think the primary purpose of your "\
  "life, of my life and the entirety of the human race's is just to blindly consume to support a "\
  'failing economy and a faulty system, forever and ever until we run out of every resource and '\
  "have to resort to blowing each other up to ensure our own survival. I don't think we're "\
  'supposed to sit by idle while we continue to use a long outdated system that produces war, '\
  'poverty, collusion, corruption, ruins our environment and threatens every aspect of our '\
  "health and does nothing but divide and segregate us. I don't think how much military "\
  "equipment we are selling to other countries, how many hydrocarbons we're burning, how much "\
  'money is being printed and exchanged, is a good measure of how healthy our society is but I do '\
  "think I can speak for everyone when I say, we're sick of this shit.\r\rTime to mobilize\r"\
  "Time to open eyes\rWe are not a quiet pocket of resistance\rThis is real, but we cannot "\
  "afford to fail\rAct with, act with persistence\rThis is real, but we cannot afford to fail"\
  "\rArmy, establish order\rRespect me and fear me\rFuck you\rWe have no respect\rAnd "\
  "when tomorrow comes\rWe're gonna stamp on your head (pig)\r\rWoah, woah\rCalm down, "\
  "(calm down mate), calm the fuck down\rGandhi Mate, Remember Gandhi (Jesus, just remember)\r"\
  "Alright, Alright I'm fine\r\rSee if we keep them silent then,\rThey'll resort to violence "\
  "and that's how we criminalize change\r\rAwhhhh,\rYabba Dabba Do One son, We don't want "\
  "your rules\rWho you fooling son, we've got all the tools\rWe need to build a whole new "\
  "system\rTo correct these flaws\r(You know what), I've already listed them\r\rYou're a "\
  "communist\rYou're a fucking utopianist\rAh here come the emulsive labels\rBut "\
  "they're attempted fails\r\r'Cause man, we so far out your comfort zone\r\rWe stop, "\
  "think, begin to revive\rWe stop, think, begin to revive\rWe stop, we think, we begin to "\
  "revive\rWe begin to revive\r\rPut a call out to the frontline\rGet the message out to the "\
  "the contact squad\rTransmit emergency frequencies\rPut a call out to the frontline\rGet the "\
  "message out to the the contact squad\rPut a call out, put a call out, put a call out\r\rOh "\
  "and the jigsaw starts to build\rOh and the jigsaw starts to build\r\rPiece\rBy\rPiece\r\r"\
  "Open their minds\r\rTransmit emergency frequencies\r\rOpen their minds\r\rTransmit "\
  "emergency frequencies\r\rEmergency frequencies\r\rEmergency frequencies\r\rEmergency "\
  "frequencies\r\rEmergency frequencies"

describe LyricWiki, 'Lyrics fetching' do
  before do
    @wiki = LyricWiki.new
  end

  describe 'with the song Enter Shikari - Gandhi Mate, Gandhi' do
    it 'fetches the right lyrics from LyricWiki' do
      lyrics = @wiki.get_lyrics('Enter Shikari', 'Gandhi Mate, Gandhi')
      _(lyrics).must_equal enter_shikari_lyrics
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song')
      assert_nil lyrics
    end
  end
end
