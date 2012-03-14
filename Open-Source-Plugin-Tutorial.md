DuckDuckGo plugins react to search queries and provide [useful](https://duckduckgo.com/?q=%40duckduckgo) [instant](https://duckduckgo.com/?q=roman+xvi) [answers](https://duckduckgo.com/?q=private+ips) above traditional links. 

This tutorial will answer:

* Why DuckDuckGo has open source plugins and why you may want to create them?

* What are the different types of plugins?

* How does a DuckDuckGo plugin work, line by line?

* What are the step by step instructions for creating, testing and submitting new plugins?


### Why plugins?

Quite simply, we think that (relevant) instant answers provide for a much better search experience. As such, we'd love to show them for as many queries as possible.

However, we're not experts in every subject, e.g. bioinformatics, and we also don't have the resources to develop plugins for niche search areas, e.g. lego parts. Yet we know there could be great instant answers in those areas and thousands of others! 

That's where you come in. You may be an expert or know an expert or know an expert site in a certain search area. If so, you're in a great position to help develop a plugin for that area. We also have an ever-increasing list of [plugin suggestions](http://duckduckgo.uservoice.com) from our user base.
 
In any case, We hope that you will consider helping to make some DuckDuckGo plugins. Here's why you might want to:

* Improve results in areas you personally search and care about, e.g. [programming documentation](https://duckduckgo.com/?q=perl+split), [gaming](https://duckduckgo.com/?q=roll+3d12+%2B+4) or [entertainment](https://duckduckgo.com/?q=xkcd).
* Increase usage of your own projects, e.g. [APIs](https://duckduckgo.com/?q=cost+of+living+nyc+philadelphia).
* Learn something new, e.g. more Perl or JavaScript.
* See your code live on a [growing](https://duckduckgo.com/traffic.html) search engine!

### Plugin types

DuckDuckGo plugins are like browser extensions, but for a search engine. There are four types of DuckDuckGo plugins:

1. **Goodies**. Example: [reverse test](https://duckduckgo.com/?q=reverse+test). The core of these plugins are self-contained Perl functions that generate instant answers (server-side).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). The core of these plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external [JSONP](https://duckduckgo.com/?q=jsonp) API calls (client-side).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on slightly-fuzzy keyword matching.

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on full-text indexing.

### A plugin line by line

We'll now walk through a complete Goodie plugin line by line. The following is the full code block that works on the query [chars test](https://duckduckgo.com/?q=chars test) and returns the number of characters of the query (after the trigger word chars). Don't worry about not getting it all yet!


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

DuckDuckGo plugins are defined in Perl, though we've constructed the system to be as condensed and as intuitive as possible. In other words, it may not look like any Perl you've seen before. Additionally, the meat of the plugin may not be in Perl at all (see Plugin types).

At the highest level, the plugin system works like this:

* We break the query (search terms) into words. This process happens in the background.

* We see if any of those words are **triggers** (trigger words) provided by all the plugins. In the example, the trigger word is **chars**.

* If a Goodie is triggered, we run its **handle** function.

* If the Goodie's handle function outputs an instant answer via a **return** statement, we pass it back to the user.

Now let's take this Goodie line by line. Feel free to open a text editor and type a parallel example along with us or look in the [Goodies repo](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/lib/DDG/Goodie) and follow along in parallel with an example there. Later we'll show you how to test it.

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

In this case there is one trigger word, **chars**. In a query like _chars test_, chars is the first word and would therefore trigger our Goodie. The **start** keyword says make sure the trigger word is at the start of the query. The => symbol is there to separate the trigger words from the keywords (for readability).

Once your triggers are specified, you then define how to **handle** the query, which is another keyword. Like triggers, handle takes a second keyword, this time explaining what to handle.

```perl
handle remainder => sub {
```

You can _handle_ different pieces of the query, but the most common is the **remainder** of it, which refers to the rest of the query (everything but the triggers). For example, if the query was _chars test string_, the trigger would be _chars_ and so the remainder would be _test string_. 

The right side of the statement (after the =>) is a function, denoted by the sub {} construction.

```perl
handle remainder => sub {
    return length $_ if $_;
    return;
};
```

This function is the meat of the Goodie that generates the instant answer (if any). Whatever you are handling is passed to the function in the $_ variable (e.g. _test string_ if the query was _chars test string_).



If you can produce a useful instant answer you just **return** it. 

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

### Creating your first plugin step by step

**Step 1.** Figure out what you want to work on. If you don't have any ideas [start here](https://duckduckgo.uservoice.com/).

**Step 2.** Figure out what type of plugin is best for your idea (see Plugin types). It's probably a Goodie (like in the line by line example) or a Spice (using a JavaScript API). If it's not obvious, please [discuss it with us](http://webchat.freenode.net/?channels=duckduckgo). If you got your plugin idea from the [suggestion list](https://duckduckgo.uservoice.com/), most are tagged with what we think would be the appropriate type.

**Step 3.** Get a [github account](https://github.com/) if you don't have one already. We use github [to host](https://github.com/duckduckgo) all of our open source code.

**Step 4.** Set up git on your computer if you haven't already. Github provides instructions for [Linux](http://help.github.com/linux-set-up-git/), [OSX](http://help.github.com/mac-set-up-git/) and [Windows](http://help.github.com/win-set-up-git/) (though Linux is preferred since that is what we use for development).

**Step 5.** Fork the right repository depending on your plugin type. If you've never forked a repository before, follow the [github directions](http://help.github.com/fork-a-repo/). Here are the links to the repositories:

 * [Goodies](https://github.com/duckduckgo/zeroclickinfo-goodies) (Perl functions)

 * [Spice](https://github.com/duckduckgo/zeroclickinfo-spice) (JavaScript functions)

 * [Fathead](https://github.com/duckduckgo/zeroclickinfo-fathead) (Keyword data)

 * [Longtail](https://github.com/duckduckgo/zeroclickinfo-longtail) (Full-text data)

You may also want to [watch the repo](http://help.github.com/be-social/) while you're at it.

**Step 6a.** If you are making a Goodie or Spice plugin (if not, skip to Step 6f), set up [local::lib](https://metacpan.org/module/local::lib), which is a way to install Perl modules without changing your base Perl installation. We've created a script to make this really easy.

```sh
curl http://duckpan.org/install.sh | perl
```

**Step 6b.** Make sure local::lib is installed right by looking for the cpanm command.

```sh
which cpanm
```

If you get a response, it's alive! If not, go back to Step 6a :(

**Step 6c.** cpanm lets you install Perl modules super easily and segments them in your home directory. Use it to install [App::DuckPAN](https://metacpan.org/module/duckpan) (our plugin utilities).

```sh
cpanm App::DuckPAN
```

**Step 6d.** Check if duckpan is installed correctly.

```sh
duckpan check
```

**Step 6e.** Go to the fork of your repository.

```sh
cd zeroclickinfo-goodies/
```

**Step 6e.** Test all the goodies.

```sh
duckpan goodie test
```

This will output all the plugins available in your repo (including the one you're working on) and then dump you to an interactive mode where you can type in queries and see the results. For Spice plugins, you will want to do additional testing (see the Spice section below).

When your plugin works like you want it to, go to Step 7.

**Step 6f.** If a Fathead or Longtail plugin, checkout the repository Readme for further details on how to format your plugin. We're still in the process of converting these plugin types to the new system.

**Step 7.** Commit and push your forked repository back to github. 

```sh
git commit -a -m "My first plugin is ready to go!"
git push
```

**Step 8.** Go into github and submit a [pull request](http://help.github.com/send-pull-requests/)! That will let us know about your plugin and start the conversation about integrating it into the live search engine.


### Spice

Spice plugins are a bit different than Goodie plugins in that their central functions (to generate the instant answers) are done in JavaScript instead of Perl. As such, there are a few extra steps to reference and test this JavaScript.

***TODO: walk through xkcd plugin when converted***


### Advanced plugin techniques

Here are some relatively common things that plugins may require.

**Multiple trigger words**.  For example, suppose you thought for the [chars goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Chars.pm) _numchars_ should also also trigger this Goodie (in addition to _chars_). Simply add the extra trigger words at the end.

```perl
triggers start => 'chars', 'numchars';
```

**Trigger locations.** As mentioned, the keyword after triggers, **start** in the Chars example, specifies where the triggers need to appear. Here are all the choices:

* start - just at the start of the query
* end - just at the end of the query
* startend - at either end of the query
* any - anywhere in the query

**Further qualifying the query.** Trigger words are blunt instruments, which may send you queries you cannot handle. As such, you generally need to further qualify the query (and return nothing in cases where the query doesn't really qualify for your goodie).

There are number of techniques for doing so. For example, the first line of [Base Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Base.pm) has a return statement paired with unless.

```perl
return unless  /^([0-9]+)\s*(?:(?:in|as)\s+)?(hex|hexadecimal|octal|oct|binary|base\s*([0-9]+))$/;
```

You could also do it the other way like the [GoldenRatio Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GoldenRatio.pm) does.

```perl
if ($input =~ /^(?:(?:(\?)\s*:\s*(\d+(?:\.\d+)?))|(?:(\d+(?:\.\d+)?)\s*:\s*(\?)))$/) {
```

Another technique is to use a hash to allow for specific query strings like the [GUID Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GUID.pm) does.

```
return unless exists $guid{$_};
```

**Handling the whole query.** In the Chars example, we handled the **remainder**. You can also handle:

* query_raw - the actual (full) query
* query - with extra whitespace removed
* query_parts - query but, given as an array of words.
* query_nowhitespace - with whitespace totally removed
* query_nowhitespace_nodash - with whitespace and dashes totally removed

For example, the [Xor Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Xor.pm) handles query_raw and the [ABC Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/ABC.pm) handles query_parts.

**Returning html**. Goodies return text instant answers by default, but could return simple html as well. In that case, simply attach the html version to the end of the return statement:

```perl
return $text, html => $html
```

**Other zci keywords**. The Chars example set the **is_cached** zci keyword. You can find other settable attributes in the [object documentation](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo). For example, the [GoldenRatio Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GoldenRatio.pm) sets the **answer_type** variable, which gets returned in the API.

```perl
zci answer_type => "golden_ratio";
```




### FAQ

1. I don't know Perl!

That's not a question :). If you don't know Perl, that's OK. First, the Longtail and Fathead plugins don't have to be written in Perl and the meat of the Spice plugins are in JavaScript. However, if you know PHP, Ruby or Python you should be able to write Goodies in Perl pretty easily using [this awesome cheat sheet](http://hyperpolyglot.org/scripting) to help you in translating your psuedo-code to Perl.


### To fit in


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