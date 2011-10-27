### Fathead (static data dumps) https://github.com/duckduckgo/zeroclickinfo-fathead

A lot of our zero-click info comes from essentially static data dumps, usually achieved through Web crawling (but could also originate from a data dump from the underlying provider). This category of 0-click involves getting the data (through crawling or from a dump) and then putting it in a form we can use. You could really do it in any language. Most of our stuff internally is in Perl, but people have already contributed in Python and node.

We call it Fat head because it deals with the "fat head" of the query space and is essentially a keyword match operation, though with some fuzziness around the edges.

We should also note that this is a win-win for the data provider since we only show a small snippet and then link back to them at the very top of the results. However, it is often a good idea to OK it with the provider ahead of time. That is also useful because sometimes they will provide you with data dumps. Otherwise, make sure you crawl at a very slow rate and/or use open sources.

To get started in this category, check out the [Readme](https://github.com/duckduckgo/zeroclickinfo-fathead/blob/master/README.md) in the [Fathead Repository](https://github.com/duckduckgo/zeroclickinfo-fathead). It explains how to organize your project, and then you can do a pull request and ultimately become a collaborator.

Here are some data/sites we would like to see.

 * More programming documentation/reference - see our current list on the [tech goodies page](http://duckduckgo.com/tech.html) (right column). Ideas are: gtk
 * ISO codes 
 * BEING WORKED ON: [Macupdate.com](http://macupdate.com)
 * BEING WORKED ON: [Iusethis.com](http://iusethis.com)
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