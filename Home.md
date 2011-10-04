# How-to help develop DuckDuckGo

A lot of people ask if they can help develop DuckDuckGo? Yes, yes, a thousand times yes! 

But how, exactly?  This document attempts to answer that question.

First, know that we have way more to do than we can handle internally. So any help is greatly appreciated. Chances are anything you do will eventually go live and so it is pretty easy to have a real impact on the search engine.

Most of DuckDuckGo is closed source, but a growing portion is [open](http://github.com/duckduckgo). We don't think it is right to ask volunteers to contribute to closed source, so what we propose here will also be open. However, if you want to work on the closed portion, there is plenty of opportunity do that as well (more on that at the bottom).

In any case, if after reading this doc you are at all interested, please contact us at open@duckduckgo.com. 

**And please, please make contact before you get started so that we can ensure the shortest path to making what you develop go live.**

## Zero-click Info

The main area where we could use help is our **Zero-click Info.** That's the stuff that appears above the traditional links and provides instant answers, topic summaries, etc. Basically, we want more of it and we want what we have to be much better!

You may have a particular niche type of search you like to do, e.g. electronics parts or program documentation, and you may have great ideas for the right 0-click source and information we should be displaying for that niche. If so, that's awesome. Work on that! We'd love to support you in that effort.

Otherwise, we have a list of our own of things we know would make good improvements and are instant projects to work on. These fall into the categories listed below.

### Fathead (static data dumps) https://github.com/duckduckgo/zeroclickinfo-fathead

A lot of our zero-click info comes from essentially static data dumps, usually achieved through Web crawling (but could also originate from a data dump from the underlying provider). This category of 0-click involves getting the data (through crawling or from a dump) and then putting it in a form we can use. You could really do it in any language. Most of our stuff internally is in Perl, but people have already contributed in Python and node.

We call it Fat head because it deals with the "fat head" of the query space and is essentially a keyword match operation, though with some fuzziness around the edges.

We should also note that this is a win-win for the data provider since we only show a small snippet and then link back to them at the very top of the results. However, it is often a good idea to OK it with the provider ahead of time. That is also useful because sometimes they will provide you with data dumps. Otherwise, make sure you crawl at a very slow rate and/or use open sources.

To get started in this category, check out the [Readme](https://github.com/duckduckgo/zeroclickinfo-fathead/blob/master/README.md) in the [Fathead Repository](https://github.com/duckduckgo/zeroclickinfo-fathead). It explains how to organize your project, and then you can do a pull request and ultimately become a collaborator.

Here are some data/sites we would like to see.

 * More programming documentation/reference - see our current list on the [tech goodies page](http://duckduckgo.com/tech.html) (right column).
 * ISO codes 
 * [Macupdate.com](http://macupdate.com)
 * [Iusethis.com](http://iusethis.com)
 * New lyrics providers, given LyricsMode has too many pop-ups and requires JS to view.
 * [Know Your Meme](http://knowyourmeme.com)
 * [TCP/UDP port #s](https://secure.wikimedia.org/wikipedia/en/wiki/List_of_TCP_and_UDP_port_numbers)
 * [Gamespot.com](http://gamespot.com)
 * [Plone](http://plone.org/) (python projects)
 * [PyPI](http://pypi.python.org/pypi) (python packages)
 * Intl phone numbers, see [this thread](https://duck.co/topic/other-0-click-infos)
 * Bible verses, see [this thread](https://duck.co/topic/other-0-click-infos)
 * Abbreviations, see [this thread](https://duck.co/topic/suggestion-0-click-info-for-abbreviation)
 * Javascript keycodes.
 * [BoardGameGeek](http://boardgamegeek.com/) (being worked on, permission granted for crawler)
 * Mime types.

### Spice (external APIs) https://github.com/duckduckgo/zeroclickinfo-spice

Feel free to edit this page and add to the above list if you have other source ideas or if you start working on one.

For 0-click that changes a lot, e.g. weather, or which requires a lot of on-the-fly processing, e.g. WolframAlpha, we use external APIs and integrate them into search results in real-time. Working on this component involves writing some JS that we would call at the appropriate time. What you would do is receive the object from the external API, massage it to extract the parts useful for 0-click, and then call an internal function to display it. 

To get started in this category, check out the [Readme](https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/README.md) in the [Spice Repository](https://github.com/duckduckgo/zeroclickinfo-spice). It explains how to organize your project, and then you can do a pull request and ultimately become a collaborator.

There are a ton of good APIs out there that we'd like to integrate, including the following.

 * [TMDb](http://api.themoviedb.org/2.1) - so we can show better movie info, like trailers.
 * BEING WORKED ON: [SoundCloud](http://developers.soundcloud.com/) - so we can let people hear music
 * [alternativeTo](http://alternativeto.net/api) - so we can display cool related topics for software
 * BEING WORKED ON: pronunciation, possibly via [Forvo](http://www.forvo.com/)
 * BEING WORKED ON: Bitcoin conversion, possibly via http://bitcoincharts.com/about/markets-api/ or https://mtgox.com/code/data/ticker.php
 * [LIVE](http://duckduckgo.com/?q=xkcd) Latest XKCD comic
 * Like [XKCD](http://duckduckgo.com/?q=xkcd) but for sinfest and SMBC (Saturday Morning Breakfast Cereal) and the doghouse diaries.
 * Qype: http://www.qype.co.uk/developers/api - like our Yelp stuff: http://duckduckgo.com/?q=black+lab+bistro but for UK & Europe.
 * Part numbers, possibly via Octopart http://octopart.com/api/overview
 * BEING WORKED ON by @dhruvbird: Khan academy https://sites.google.com/a/khanacademy.org/forge/for-developers/technical/api
 * Infochimps http://www.infochimps.com/apis (for data * searches)
 * BEING WORKED ON Twitter for latest tweets and bio info, e.g. when someone types in @yegg
 * Translator
 * News API
 * From [this thread](https://duck.co/topic/other-0-ckick-info-idea-train-departure) "DDG should check for train departure"
 * Is it down, using an API from one of the is it down web sites.

Feel free to edit this page and add to the above list if you have other source ideas or if you start working on one.


### Goodies https://github.com/duckduckgo/zeroclickinfo-goodies

For some 0-click we don't use any source but ourselves :). These range from [cheat sheets](http://duckduckgo.com/?q=html+chars) to [tools](http://duckduckgo.com/?q=pw) to [info](http://duckduckgo.com/?q=%23564). Cheat sheets can be an external HTML file we call via an iFrame but the processing goodies are written in Perl since they get inserted into our core processing engine. Often there are existing Perl modules that will do things, which are ripe for Goodies. There are lots of Goodie ideas out there, including the following.

 * em to px converter 
 * spelling corrector. We have spelling now but this would be more an explicit attempt to think of alternatives.
 * rhyming dictionary.
 * SUBMITTED (warthurton): throw dice.
 * SUBMITTED (warthurton): three way choice, expanding on our two way now http://duckduckgo.com/?q=yes+or+no.
 * Improve "lorem ipsum" http://duckduckgo.com/?q=lorem+ipsum goodie so that it shows different text each time
 * [LIVE](http://duckduckgo.com/?q=public+dns) (warthurton): Public DNS servers.
 * Poker hands/probabilities
 * [LIVE](http://duckduckgo.com/?q=guid) : GUID generator
 * Javascript character codes
 * More [easter eggs](https://duckduckgo.com/?q=answer+to+the+ultimate+question+of+life+the+universe+and+everything)
 * Parsing crontab formats and explaining how they get called in a human readable manner :)
 * A cheat sheet for all the goodies!
 * Joke/Sad/Funny -- random joke
 * Fun -- random fun thing (flash game?)
 * Suicide hotline #s.
 * From [this thread](https://duck.co/topic/is-it-christmas-zero-click-info) "This would kind of be a fun one. A zero-click box sourced from isitchristmas.com would be hilarious. What say you all?"
 * From [this thread](https://duck.co/topic/zero-click-info-idea-reverse-dns) Reverse DNS
 * Passphrase, e.g. passphrase 4 words => Metro Justice Carrot Running -- perhaps using Diceware in some way?

To get started in this category, check out the [Readme](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/README.md) in the [Goodies Repository](https://github.com/duckduckgo/zeroclickinfo-goodies). It explains how to organize your project, and then you can do a pull request and ultimately become a collaborator.

Feel free to edit this page and add to the above list if you have other source ideas or if you start working on one.

### When to call 0-click

For each piece of 0-click info, we have to know when to call it. For the static (data dumps) we have a system that does this pretty well. For the dynamic (APIs and goodies) we have a number of schemes to determine when they get called depending on the situation, e.g. [pieces of regexp](https://duckduckgo.com/walpha.html), hashes or more complicated one-off query processing. This area can always be improved, usually by expanding its scope for a particular source such that we get more 0-click coverage without many false positives.

 * A major example here is finding more of WolframAlpha we can use, and there is a lot more!

## Other open stuff

In addition to the 0-click stuff, there are other things that are open that might spark your interest.

 * Logos. We'd love [more logos](http://duckduckgo.com/logos.html) for various holidays. We have [a repository](https://github.com/duckduckgo/logos) that contains base source files. To make this really easy, just make the logo [the right size](http://duckduckgo.com/nduck.v104.png) (with the words - 200x132) so we can use them as a drop-in replacement. There is also a [forum](https://duck.co/#Forum/duckduckgo-graphics) dedicated to this purpose.
 * Mobile logos. None of the above logos are [formatted for mobile](http://duckduckgo.com/nduck.v105.mobile.png). It is a repetitive task, but if you'd like to make some mobile versions of the [existing specialty logos](http://duckduckgo.com/logos.html) that would be awesome and next time we put them up we can use both versions.
 * API helper libaries. More libraries (in your favorite language) to use our [0-click API](http://api.duckduckgo.com/)
 * Themes. We're working on a dark theme, but could use other ideas. Ultimately, we'd like to have a theme collection.
 * Grouping settings. We have [a lot of settings](http://duckduckgo.com/settings.html), which is great, but they can get overwhelming. We have a thought to offer collections of these so you could get the widescreen or minimal or whatever version and it would change a bunch at once. Determining good sets of collections would be very useful.
 * We are also developing a [community platform](http://github.com/duckduckgo/community-platform), more information about helping there you get in [this thread](https://duck.co/topic/duckduckgo-community-and-42).

## Closed stuff

As mentioned at the top, there is also an opportunity to work on some closed source stuff. Obviously there are a lot of components there, but we could really use help right now building browser extensions.

## Contact

Thank you for getting this far in this (admittedly long) document! If you're interested, please contact us at open@duckduckgo.com. If you're unsure of what to make of the above, we can try to help steer you into something that fits your skill set and/or interests.

Also note that this document is very work-in-progress. So if you have any ideas for suggestions on how to improve it, please let us know.