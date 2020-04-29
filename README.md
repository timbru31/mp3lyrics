# MP3Lyrics
[![Ruby](https://github.com/timbru31/mp3lyrics/workflows/Ruby/badge.svg)](https://github.com/timbru31/mp3lyrics/actions?query=workflow%3ARuby)

[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/timbru31/mp3lyrics.svg)](https://codeclimate.com/github/timbru31/mp3lyrics/coverage)
[![Coverage Status](https://img.shields.io/coveralls/timbru31/mp3lyrics.svg)](https://coveralls.io/github/timbru31/mp3lyrics?branch=master)
![Code Climate](https://img.shields.io/codeclimate/maintainability/timbru31/mp3lyrics.svg)
[![Known Vulnerabilities](https://snyk.io/test/github/timbru31/mp3lyrics/badge.svg)](https://snyk.io/test/github/timbru31/mp3lyrics)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=timbru31/mp3lyrics)](https://dependabot.com)

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)

### Still in Alpha, ugly and WIP :)

## Info

MP3Lyrics is a tool written in Ruby (currently only CLI) to download song lyrics from [LyricWikia](http://lyrics.wikia.com), [MetroLyrics](http://metrolyrics.com), [AZLyrics](https://www.azlyrics.com) and [Genius](https://genius.com).
The lyrics are added to the mp3 file via the [USLT (Unsynchronised lyric/text transcription)](http://id3.org/id3v2.4.0-frames) tag (with the power of [ruby-mp3info](https://github.com/moumar/ruby-mp3info)).

## Motivation

#### Why Ruby?

Because I wanted to try another language than Java.

#### Why are you not using the LyricWikia API?

~~Although they have got a pretty neat [REST API](http://api.wikia.com/wiki/LyricWiki_API/REST) the lyrics can't be fully retrieved, most likely due to licensing issues.~~
They no longer offer an API since January 2016.

#### Why are you not using musiXmatch API?

Simply because they charge me (the developer) for retrieving the lyrics.

#### Why are you not using MetroLyrics API?

I don't have an API key (yet).

#### Why are you not using Genius API?

They do not offer fetching lyrics via the API (yet).

#### Why not iTunes Lyrics Adder, Lyrics for iTunes, iSongText, Get Lyrical, ...?

Either they were tied to iTunes and ugly DLL libraries, outdated/inactive, closed source or not cross platform. I'm mainly developing on my MacBook and my iTunes library is on my Windows system. I need something that works anywhere.

By dropping the need (and support) of iTunes running somewhere in the background, the tool is more lightweight.

## Dependencies

1. Bundler
2. Nokogiri for HTML parsing
3. mp3info as a MP3 library
4. require_all for easier requiring of the wiki_api folder
5. For testing purposes you should install rubocop, rake, minitest and optionally coverage reporters for CodeClimate and Coveralls

## Installation


```shell
gem install bundler
bundle install
```

## Usage

```shell
./mp3lyrics.rb <dir> [-override true/false] [-use lyricwikia/genius/metrolyrics/azlyrics]
```
**dir** is the folder with your music, it's iterated recursively.  
**override** is a boolean toggle to override existing lyrics (defaults to *false*).  
**use** is a specific wiki to be used to download lyrics (all wikis are used by default).

## Tests

To execute the tests run
```shell
bundle exec rake
```

## Future plans // ToDo

- ~~Add support to other lyrics sites when 404 is returned from LyricWikia~~
- GUI for easier usage (maybe)
- Add test cases, see [#1](https://github.com/timbru31/mp3lyrics/issues/1)

---
Built by (c) Tim Brust and contributors. Released under the MIT license.
