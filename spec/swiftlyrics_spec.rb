require './wiki_api/Wiki'
require './wiki_api/SwiftLyrics'

ffdp_lyrics = "No one gets left behind, another fallen soul\rNo one gets left behind, another broken home\r"\
  "No one gets left behind, we stand and fight together\rNo one gets left behind but we all die alonePoliticians bathing in their greed\r"\
  "No idea on how to be all they can beHave you no honor? Have you no soul?\rWhat is it they're dying for do you really even know?\r"\
  "Have you no backbone? Have you no spine?\rWhatever happened to no one gets left behind?No one gets left behind, I know you made it up\r"\
  "No one gets left behind, it's war for money\rNo one gets left behind, drink from the golden cup\rNo one gets left behind, you're time is coming"\
  "Play your war games with other people's lives\rIt should be you on the frontlineHave you no honor? Have you no soul?\rWhat is it they're "\
  "dying for do you really even know?\rHave you no backbone? Have you no spine?\rWhat ever happened to no one gets left behindHave you no honor? "\
  "Have you no soul?\rWhat is it they're dying for do you really even know?\rHave you no backbone? Have you no spine?\r"\
  "Whatever happened to no one gets left behind?No one gets left behind\rNo one gets left behind\rNo one gets left behind\r"\
  "No one gets left behind\rNo one gets left behind"

RSpec.describe SwiftLyrics, 'Lyrics fetching' do
  context 'with the song Five Finger Death Punch - No One Gets Left Behind' do
    it 'fetches the right lyrics from SwiftLyrics' do
      wiki = SwiftLyrics.new
      lyrics = wiki.get_lyrics('Five Finger Death Punch', 'No One Gets Left Behind')
      expect(lyrics).to eq ffdp_lyrics
    end
  end
  context 'with the song Non Existing - No Song' do
    it 'returns nil since this song does not exist' do
      wiki = SwiftLyrics.new
      lyrics = wiki.get_lyrics('Non Existing', 'No Song')
      expect(lyrics).to eq nil
    end
  end
end
