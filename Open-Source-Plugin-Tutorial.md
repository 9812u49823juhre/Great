DuckDuckGo plugins react to search queries and provide useful instant answers above the traditional link results.

There are four types of plugins:

1. **Goodies**. Example: [reverse this query](https://duckduckgo.com/?q=reverse+this+query). These plugins are self-contained Perl functions that generate instant answers (server-side).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). These plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external JSONP API calls (client-side).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on slightly-fuzzy keyword matching.

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on full-text indexing.

Goodies and Spice plugins are really easy to make (explained below). Fathead and Longtail plugins are still being converted to this new system. If you'd like to work on Fathead, check out [this readme](https://github.com/duckduckgo/zeroclickinfo-fathead). For Longtail, please contact us at open@duckduckgo.com.

### Goodies

Here's the code for the reverse Goodie example above.

```perl
package DDG::Goodie::Reverse;
# ABSTRACT: Reverse the order of chars in the remainder

use DDG::Goodie;

triggers startend => 'reverse';

handle matches => sub { join('',reverse split(//,$_[0])) };

zci is_cached => 1;

1;
```

Even if you don't know any Perl, Goodies should still be easy to make. Let's take each block in turn.

```perl
package DDG::Goodie::Reverse;
# ABSTRACT: Reverse the order of chars in the remainder
```

This defines a Perl package for your Goodie, which we will import into our back-end. You would change **Reverse** to your name (CamelCase). 

You probably guessed # lines are comments. # ABSTRACT: is a special comment line that gets automatically parsed by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla) to make nice documentation.

```perl
use DDG::Goodie;
```

This [use statement](https://duckduckgo.com/?q=perl+use) imports [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system so that the following blocks work. Operationally it adds various functions and objects to the local namespace.

```perl
triggers startend => 'reverse';
```

Triggers is a keyword (internally it is just a hash) that specifies on what queries the Goodie operates. Think of triggers as **trigger words**. We take the query and break it up into words and then use those words to trigger the Goodies. You can specify where those words need to appear:
* start - just at the start of the query
* end - just at the end of the query
* startend - at either end of the query
* any - anywhere in the query

