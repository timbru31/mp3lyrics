require 'net/http'
require 'nokogiri'
require 'mp3info'

class Wiki
  def fetch(uri_str, limit = 10)
    fail ArgumentError, 'The wiki site is redirecting too much, aborting...' if limit == 0

    url = URI.parse(uri_str)
    req = Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    case response
    when Net::HTTPRedirection then fetch(response['location'], limit - 1)
    else
      response
    end
  end

  def set_lyrics(file, lyrics)
    Mp3Info.open(file) do |mp3|
      mp3.tag2.USLT = lyrics
    end
  end
end
