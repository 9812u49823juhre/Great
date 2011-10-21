# How-to help develop DuckDuckGo

A lot of people ask if they can help develop DuckDuckGo? Yes, yes, a thousand times yes! But how, exactly?  This working document attempts to answer that question.

First, know that we have way more to do than we can handle internally. So any help is greatly appreciated. Chances are anything you do will eventually go live and so it is pretty easy to have a real impact on the search engine. It also relatively easy to influence the parts you personally care about, e.g. define instant answers for the types of queries you find yourself doing.

Much of DuckDuckGo is closed source, but a growing portion is [open](http://github.com/duckduckgo). We don't think it is right to ask volunteers to contribute to closed source, so what we propose here will also be open. However, if you want to work on the closed portion, there is plenty of opportunity do that as well (more on that at the bottom).

In any case, you can reach us at open@duckduckgo.com. We're happy to answer your questions, or help you figure out something useful to work on. We would like to ensure the shortest path to making what you want to develop go live.**

## Zero-click Info

The main area where we could use help is our **Zero-click Info.** That's the stuff that appears above the traditional links and provides instant answers, topic summaries, etc. Basically, we want more of it and we want what we have to be much better!

You may have a particular niche type of search you like to do, e.g. electronics parts or program documentation, and you may have great ideas for the right 0-click source and information we should be displaying for that niche. If so, that's awesome. Work on that! We'd love to support you in that effort.

Otherwise, we have a list of our own of things we know would make good improvements and are instant projects to work on. These fall into the categories listed below.

### [Fathead](https://github.com/duckduckgo/duckduckgo/wiki/Fathead)

### [Spice](https://github.com/duckduckgo/duckduckgo/wiki/Spice)

### [Goodies](https://github.com/duckduckgo/duckduckgo/wiki/Goodies)

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