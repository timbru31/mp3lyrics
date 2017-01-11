require_relative './spec_helper'
require_relative '../lib/swiftlyrics'

ffdp_lyrics = "No one gets left behind, another fallen soul\rNo one gets left behind, another "\
  "broken home\rNo one gets left behind, we stand and fight together\rNo one gets left behind "\
  "but we all die alone\rPoliticians bathing in their greed\rNo idea on how to be all they can "\
  "be\rHave you no honor? Have you no soul?\rWhat is it they're dying for do you really even know?"\
  "\rHave you no backbone? Have you no spine?\rWhatever happened to no one gets left behind?\rNo "\
  "one gets left behind, I know you made it up\rNo one gets left behind, it's war for money\rNo "\
  "one gets left behind, drink from the golden cup\rNo one gets left behind, you're time is "\
  "coming\rPlay your war games with other people's lives\rIt should be you on the frontline\rHave "\
  "you no honor? Have you no soul?\rWhat is it they're dying for do you really even know?\rHave "\
  "you no backbone? Have you no spine?\rWhat ever happened to no one gets left behind\rHave you no "\
  "honor? Have you no soul?\rWhat is it they're dying for do you really even know?\rHave you no "\
  "backbone? Have you no spine?\rWhatever happened to no one gets left behind?\rNo one gets left "\
  "behind\rNo one gets left behind\rNo one gets left behind\rNo one gets left behind\rNo one "\
  "gets left behind\r\r"

describe SwiftLyrics, 'Lyrics fetching' do
  before do
    @wiki = SwiftLyrics.new
  end

  describe 'with the song Five Finger Death Punch - No One Gets Left Behind' do
    it 'fetches the right lyrics from SwiftLyrics' do
      lyrics = @wiki.get_lyrics('Five Finger Death Punch', 'No One Gets Left Behind')
      lyrics.must_equal ffdp_lyrics
    end
  end

  describe 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      lyrics = @wiki.get_lyrics('Non Existing', 'No Song')
      assert_nil lyrics
    end
  end
end
