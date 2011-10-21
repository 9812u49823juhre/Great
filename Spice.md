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
