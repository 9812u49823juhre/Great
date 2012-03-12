DuckDuckGo plugins react to search queries and provide [useful](https://duckduckgo.com/?q=%40duckduckgo) [instant](https://duckduckgo.com/?q=roman+xvi) [answers](https://duckduckgo.com/?q=private+ips) above traditional links. 

This tutorial will explain:

* Why DuckDuckGo has open source plugins and why you may want to create them.

* What are the different types of DuckDuckGo plugins.

* How a DuckDuckGo plugin works line by line.

* Step by step instructions on creating, testing and submitting new plugins.


### Why plugins?

Quite simply, we think that (relevant) instant answers provide for a much better search experience. As such, we'd love to show them for as many queries as possible.

We're not experts in every subject though, e.g. bioinformatics, and we also don't have the resources to develop plugins for niche search areas, e.g. lego parts. However, we think there could be great instant answers in those areas and thousands of others! 

That's where you come in. You may be an expert or know an expert or know an expert site in a certain search area. If so, you're in a great position to help develop a plugin for that area. We also have an ever-increasing list of [plugin suggestions](http://duckduckgo.uservoice.com) from our user base.
 
In any case, We hope that you will consider helping to make some DuckDuckGo plugins. Here's why you might want to:

* Improve results in areas you personally search and care about, e.g. [programming documentation](https://duckduckgo.com/?q=perl+split), [gaming](https://duckduckgo.com/?q=roll+3d12+%2B+4) or [entertainment](https://duckduckgo.com/?q=xkcd).
* Increase usage of your own projects, e.g. [APIs](https://duckduckgo.com/?q=cost+of+living+nyc+philadelphia).
* Learn something new, e.g. more Perl or JavaScript.
* See your code live on a [growing](https://duckduckgo.com/traffic.html) search engine!

### Plugin types

There are four types of DuckDuckGo plugins:

1. **Goodies**. Example: [reverse test](https://duckduckgo.com/?q=reverse+test). These plugins are self-contained Perl functions that generate instant answers (server-side).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). These plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external [JSONP](https://duckduckgo.com/?q=jsonp) API calls (client-side).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on slightly-fuzzy keyword matching.

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on full-text indexing.

### A plugin line by line

We will now walk through a complete Goodie plugin line by line. The following is the full code block that works on the query [chars test](https://duckduckgo.com/?q=chars test). Don't worry about not getting it yet!


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

The code block is in Perl, though we've constructed the DuckDuckGo plugin system to be as condensed and as intuitive as possible. In other words, it may not look like any Perl you've seen before.

At the highest level, the plugin system like this:

* We break the query into words (in the background).

* We see if any of those words match the trigger words provided by all the plugins (in this case **chars**).

* If a Goodie is triggered, we run its **handle** function.

* If the Goodie's handle function returns an instant answer, we pass it back to the user.

Now let's take this Goodie line by line. Feel free to open a text editor and type a parallel example along with us. Later we'll show you how to test it.

Each plugin is a [Perl package](https://duckduckgo.com/?q=perl+package) underneath, so we start by declaring the package namespace.

```perl
package DDG::Goodie::Chars;
# ABSTRACT: Give the number of characters (length) of the query.
```

You would change **Chars** to the name of your plugin (written in [CamelCase](https://duckduckgo.com/?q=camelcase) format). 

You probably guessed # denotes a comment. _# ABSTRACT:_ is a special comment line that gets automatically parsed by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla) to make nice documentation.

Next we have a [use statement](https://duckduckgo.com/?q=perl+use) that imports [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system into the local namespace (in this case the Goodie system).

```perl
use DDG::Goodie;
```

Then we see the **triggers** keyword that specifies on what queries the Goodie operates. Think of triggers as _trigger words_. We take the query and break it up into words and then use those words to _trigger_ DuckDuckGo plugins. 

```perl
triggers start => 'chars';
```

In this case there is one trigger word, **chars**. In a query like _chars test_, chars is the first word and would therefore trigger our Goodie. The **start** keyword says make sure the trigger word is at the start of the query. The => symbol is an assignment operator that separates the trigger words from the keywords.


Once your triggers are specified, you then define how to **handle** the query, which is another keyword. Like triggers, handle takes a second keyword, this time explaining what to handle.

```perl
handle remainder => sub {
```

You can _handle_ different pieces of the query, but the most common is **remainder**, which refers to the _remainder_ of the query (everything but the triggers). For example, if the query was _chars test string_, the trigger would be _chars_ and so the remainder would be _test string_. 

The right side of the assignment (=>) is a function, denoted by the sub {} construction.

```perl
handle remainder => sub {
    return length $_ if $_;
    return;
};
```

This function is the meat of the Goodie that generates the instant answer (if any). Whatever you are handling is passed to the function in the $_ variable. 



If you can produce a useful instant answer you just return it as one Scalar (as opposed to an Array, ArrayRef or HashRef). 

```perl
return length $_ if $_;
```

In this case, the heart of the function is just this one line. The remainder is in the $_ variable. If it is not blank (**if $_**), we return the number of chars using [perl's length built-in](https://duckduckgo.com/?q=perl+length).

Perl has a lot of built-in functions, but it also has thousands and thousands of modules available [via CPAN](https://metacpan.org/). You can leverage most of these modules when making Goodies, like how the [Roman Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Roman.pm) uses the [Roman module](https://metacpan.org/module/Roman).

If you are unable to provide a good instant answer, you can simply return nothing. You'll notice we did that if $_ didn't contain anything.

```perl
return;
```

Goodies technically return a [ZeroClickInfo object](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo) (abbreviated as zci). This effect happens transparently by default, but you can override this default behavior via the **zci** keyword.

For example, if your Goodie always returns the same answer for the same query, we could speed up future answers by caching (saving previous answers). In this case, you may want to set **is_cached** like in the example.

```perl
zci is_cached => 1;
```

Finally, all Perl packages that load correctly should [return a true value](http://stackoverflow.com/questions/5293246/why-the-1-at-the-end-of-each-perl-package).

```perl
1;
```

### Creating your first plugin

1. Figure out what you want to work on. If you have any questions or want to discuss it with us please do!

2. Figure out what type of plugin is best for your idea. It's probably obvious, but if not please discuss it with us.

3. Fork the right repository on the [DuckDuckGo github](https://github.com/duckduckgo)

 * [Goodies](https://github.com/duckduckgo/zeroclickinfo-goodies)

 * [Spice](https://github.com/duckduckgo/zeroclickinfo-spice)

 * [Fathead](https://github.com/duckduckgo/zeroclickinfo-fathead)

 * [Longtail](https://github.com/duckduckgo/zeroclickinfo-longtail)

4. Checkout the repository Readme for further details.

5. Submit a pull request!




### Advanced techniques

You can also use multiple trigger words. For example, suppose you thought _numchars_ should also also trigger this Goodie (in addition to chars).

 You can find other attributes in the [object documentation](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo).
```perl
triggers start => 'chars', 'numchars';
```

As mentioned, the keyword after triggers, in this case **start**, specifies where the triggers need to appear:

* start - just at the start of the query
* end - just at the end of the query
* startend - at either end of the query
* any - anywhere in the query

You can also handle:

* query_raw - the actual (full) query
* query - with extra whitespace removed
* query_nowhitespace - with whitespace totally removed
* query_nowhitespace_nodash - with whitespace and dashes totally removed




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


### Plugin ideas


### FAQ

1. I don't know Perl!

That's not a question :). If you don't know Perl, that's OK. First, the Longtail and Fathead plugins don't have to be written in Perl and the meat of the Spice plugins are in JavaScript. However, if you know PHP, Ruby or Python you should be able to write Goodies in Perl pretty easily using [this awesome cheat sheet](http://hyperpolyglot.org/scripting) to help you in translating your psuedo-code to Perl.


