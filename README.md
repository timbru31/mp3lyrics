# MP3Lyrics
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/847daeb2c69a4ebebfca3f204b7c164f)](https://www.codacy.com/app/timbru31/mp3lyrics?utm_source=github.com&utm_medium=referral&utm_content=timbru31/mp3lyrics&utm_campaign=badger)
[![Dependency Status](https://img.shields.io/gemnasium/timbru31/mp3lyrics.svg)](https://gemnasium.com/timbru31/mp3lyrics)
[![Code Climate](https://img.shields.io/codeclimate/github/timbru31/mp3lyrics.svg)](https://codeclimate.com/github/timbru31/mp3lyrics)
[![Build Status](https://img.shields.io/travis/timbru31/mp3lyrics.svg)](https://travis-ci.org/timbru31/mp3lyrics)
[![Circle CI](https://img.shields.io/circleci/project/timbru31/mp3lyrics.svg)](https://circleci.com/gh/timbru31/mp3lyrics)
[![Build status](https://ci.appveyor.com/api/projects/status/c7misjwgqj4dc26d?svg=true)](https://ci.appveyor.com/project/timbru31/mp3lyrics)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/timbru31/mp3lyrics.svg)](https://codeclimate.com/github/timbru31/mp3lyrics/coverage)
[![Coverage Status](https://img.shields.io/coveralls/timbru31/mp3lyrics.svg)](https://coveralls.io/github/timbru31/mp3lyrics?branch=master)
[![License](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-blue.svg)](LICENSE.md)

### Still in Alpha, ugly and WIP :)

## Info

MP3Lyrics is a tool written in Ruby (currently only CLI) to download song lyrics from [LyricWikia](http://lyrics.wikia.com), [MetroLyrics](http://metrolyrics.com), [AZLyrics](http://azlyrics.com), [SwiftLyrics](http://swiftlyrics.com) and [Genius](http://genius.com).
The lyrics are added to the mp3 file via the [USLT (Unsynchronised lyric/text transcription) ](http://id3.org/id3v2.4.0-frames) tag (with the power of [ruby-mp3info](https://github.com/moumar/ruby-mp3info)).

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

### A note for Windows users

I have successfully run the CLI on Windows. RubyInstaller works fine, just make sure to skip the development group of the Gemfile
```shell
bundle install --without development
```

## Usage

```shell
./mp3lyrics.rb <dir> [override]
```
Where **dir** is the folder with your music, it's iterated recursively and **override** is a boolean toggle to override existing lyrics (defaults to *false*)

## Tests

To execute the tests run
```shell
bundle exec rake
```

## Future plans // ToDo

- ~~Add support to other lyrics sites when 404 is returned from LyricWikia~~
- GUI for easier usage (maybe)
- Add test cases, see [#1](https://github.com/timbru31/mp3lyrics/issues/1)

## License
This plugin is released under the
*Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)* license.

Please see [LICENSE.md](LICENSE.md) for more information.
