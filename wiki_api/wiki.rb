require 'mp3info'
require 'net/http'
require 'nokogiri'
require 'pry'

# Base class to fetch different lyrics sites
class Wiki
  def fetch(uri_str, limit = 10)
    fail ArgumentError, 'The wiki site is redirecting too much, aborting...' if limit == 0
    uri_str = URI.encode(uri_str)
    uri_str.gsub!('%EF%BB%BF', '') # fix BOM
    url = URI.parse(uri_str)
    req = Net::HTTP::Get.new(url.path)
    response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
    case response
    when Net::HTTPRedirection then
      fetch(response['location'], limit - 1)
    else
      response
    end
  end

  def set_lyrics(mp3, lyrics)
    mp3.tag2.USLT = lyrics
  end
end
