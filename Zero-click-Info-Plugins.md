Zero-click Info plugins react to search queries and provide useful instant answers (Zero-click Info) above the traditional link results.

[This Trello board](https://trello.com/board/duckduckgo-open-source-plugins/4f08e96d947729b526070890) serves as a plugin organization hub. Check out the live plugins listed on the right of the board and the requested plugins on the left. In the middle are plugins in process, each with its own place on github.

## What to work on

You may have a particular niche type of search you like to do, e.g. electronics parts or program documentation, and you may have great ideas for the right information DuckDuckGo should be displaying for that niche. If so, please work on that! Or, feel free to pick up any of the plugin requests on the board.


## Plugin repositories

The Zero-click Info plugins are organized on github into repositories based upon their underlying structure.

* **[Goodies](https://github.com/duckduckgo/duckduckgo/wiki/Goodies)** - standalone Perl (i.e. no external requests). These plugins take a set of queries and turn them into an instant answer via a transformation of some kind, e.g. md5 hashes, rolling a die, etc.

* **[Spice](https://github.com/duckduckgo/duckduckgo/wiki/Spice)** - JavaScript. These plugins call external JSONP APIs, e.g. grab the latest XKCD comic, bitcoin prices, etc.

* **[Fathead](https://github.com/duckduckgo/duckduckgo/wiki/Fathead)** - standalone data. These plugins output data files that show snippet information from a particular source, e.g. a C++ reference.