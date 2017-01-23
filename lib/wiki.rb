require 'net/http'
require 'nokogiri'

# Base class to fetch different lyrics sites
class Wiki
  def fetch(uri_str, limit = 10)
    raise ArgumentError, 'The wiki site is redirecting too much, aborting...' if limit.zero?
    uri = prepare_url(uri_str)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      req = Net::HTTP::Get.new(URI.encode(uri.path))
      begin
        http.request(req)
      rescue EOFError
        put 'rescue'
      end
    end
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

  def prepare_url(uri_str)
    uri_str.gsub!('%EF%BB%BF', '') # fix BOM
    URI.parse(uri_str)
  end
end
