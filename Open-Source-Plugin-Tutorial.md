DuckDuckGo plugins react to search queries and provide [useful](https://duckduckgo.com/?q=%40duckduckgo) [instant](https://duckduckgo.com/?q=roman+xvi) [answers](https://duckduckgo.com/?q=private+ips) above traditional links. 

### Overview 

We think that (relevant) instant answers provide for a much better search experience, and so we'd love to show them for as many queries as possible.

We hope that you will consider helping to make some. Here's why you might want to:

* Improve search results in areas you personally search and care about, e.g. [programming documentation](https://duckduckgo.com/?q=perl+split), [gaming](https://duckduckgo.com/?q=roll+3d12+%2B+4) or [entertainment](https://duckduckgo.com/?q=xkcd).
* Increase usage of your own projects, e.g. [APIs](https://duckduckgo.com/?q=cost+of+living+nyc+philadelphia).
* Learn something new, e.g. Perl or JavaScript.
* See your code live on a [growing](https://duckduckgo.com/traffic.html) search engine!

### Plugin types

There are four types of DuckDuckGo plugins:

1. **Goodies**. Example: [reverse test](https://duckduckgo.com/?q=reverse+test). These plugins are self-contained Perl functions that generate instant answers (server-side).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). These plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external [JSONP](https://duckduckgo.com/?q=jsonp) API calls (client-side).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on slightly-fuzzy keyword matching.

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on full-text indexing.

### Example

Here's an example Goodie that works on the query [chars test](https://duckduckgo.com/?q=chars test).

```perl
package DDG::Goodie::Chars;
# ABSTRACT: Give the number of characters (length) of the query.

use DDG::Goodie;

triggers start => 'chars';

handle remainder => sub {
    return length $_ if $_;
    return;
};

zci is_cached => 1;

1;
```

Let's take that line by line. Each plugin is a [Perl package](https://duckduckgo.com/?q=perl+package) underneath, so we start by declaring the package namespace.

```perl
package DDG::Goodie::Chars;
# ABSTRACT: Give the number of characters (length) of the query.
```

You would change **Chars** to your plugin's name ([CamelCase](https://duckduckgo.com/?q=camelcase)). 

You probably guessed # denotes a comment. _# ABSTRACT:_ is a special comment line that gets automatically parsed by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla) to make nice documentation.

Next we have a [use statement](https://duckduckgo.com/?q=perl+use) that imports [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system into the local namespace (in this case the Goodie system).

```perl
use DDG::Goodie;
```

Then we see the **triggers** keyword that specifies on what queries the Goodie operates. Think of triggers as _trigger words_. We take the query and break it up into words and then use those words to _trigger_ Goodies (and also Spice plugins). 

```perl
triggers start => 'char';
```

You can use multiple trigger words.

```perl
triggers start => 'capitalize', 'uppercase';
```

The keyword after triggers, in this case **start**, specifies where the triggers need to appear:

* start - just at the start of the query
* end - just at the end of the query
* startend - at either end of the query
* any - anywhere in the query

Once your triggers are specified, you then define how to **handle** the query, which is another keyword. 

```perl
handle remainder => sub {
    return length $_ if $_;
    return;
};
```

You can _handle_ different pieces of the query, but the most common is **remainder**, which refers to the _remainder_ of the query (everything but the triggers). For example, if the query was _chars test string_, the trigger would be _chars_ and so the remainder would be _test string_. 

Whatever you are handling is passed to the function in the $_ variable. You can also handle:

* query_raw - the actual (full) query
* query - with extra whitespace removed
* query_nowhitespace - with whitespace totally removed
* query_nowhitespace_nodash - with whitespace and dashes totally removed

If you can produce a useful instant answer you just return it as one Scalar (as opposed to an Array, ArrayRef or HashRef). 

```perl
return length $_ if $_;
```

If you are unable to provide a good instant answer, you can simply return nothing. You'll notice we did that if $_ didn't contain anything.

```perl
return;
```

Goodies technically return a [ZeroClickInfo object](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo). This effect happens transparently by default, but you can override this default behavior via the **zci** keyword.

For example, you may want to set **is_cached** if your instant answer never expires. You can find other attributes in the [object documentation](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo).

```perl
zci is_cached => 1;
```


Finally, all Perl packages that load correctly should [return a true value](http://stackoverflow.com/questions/5293246/why-the-1-at-the-end-of-each-perl-package).

```perl
1;
```

### Goodies

### Spice


### Advanced techniques

You can see a lot of other working Goodie examples in our [zeroclickinfo-goodies repository](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/lib/DDG/Goodie). Feel free to fork it, play around and submit a pull request!

### Testing plugins
TODO: integrate https://metacpan.org/module/duckpan


### Fathead

We are working on translating Fathead plugins into the Duckpan system. In the meantime you can check out our old Readme in the [zeroclickinfo-fathead repository](https://github.com/duckduckgo/zeroclickinfo-fathead).

The output is a tab delimited file that could be produced in almost any language. Checkout the directories in that repository for a number of examples, some live and some still in development.

A great way to get started would be to make more reference documentation, e.g. for your favorite programming languages/tools.

### Longtail

If you have an idea for data you think would be useful for full-text indexing to produce instant answers, please let us know at open@duckduckgo.com. We will work with you to get it integrated.

The output would be a data file grouped by paragraphs and meta data (headings, URLs, etc.). You could use a variety of languages to generate this data file.

Examples of existing longtail integrations are [Wikipedia](https://duckduckgo.com/?q=snow+albedo) and [Stack Exchange](https://duckduckgo.com/?q=nginx%20lighttpd&ky=-1). On the open source side we have [lyrics](https://github.com/duckduckgo/lyrics) (Python) and are working on [Quora](https://github.com/duckduckgo/zeroclickinfo-longtail/tree/master/quora-crawler) (Node).


TODO: and in testing and DuckPan info when ready.

cpanm App::DuckPAN
duckpan setup
duckpan check
duckpan DDG

* If you know Python, Ruby or PHP, [this awesome cheat sheet](http://hyperpolyglot.org/scripting) should help you in translating your logic to Perl.

### Plugin ideas