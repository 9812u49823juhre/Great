DuckDuckGo plugins react to search queries and provide [useful](https://duckduckgo.com/?q=%40duckduckgo) [instant](https://duckduckgo.com/?q=roman+xvi) [answers](https://duckduckgo.com/?q=private+ips) above traditional links. 

This tutorial will answer:

* Why DuckDuckGo has open source plugins and why you may want to create them?

* What are the different types of plugins?

* How does a DuckDuckGo plugin work, line-by-line?

* What are the step-by-step instructions for creating, testing, and submitting new plugins?


### Why plugins?

Quite simply, we think that (relevant) instant answers provide a much better search experience. As such, we'd love to show them for as many queries as possible.

However, we're not experts in every subject, e.g. bioinformatics, nor do we have the resources to develop plugins for niche search areas, e.g. lego parts, but we know there could be great instant answers in those areas and thousands of others! 

That's where you come in. You may be an expert or know an expert or know an expert site in a certain search area. If so, you're in a great position to help develop a plugin for that area. We also have an ever-increasing list of [plugin suggestions](http://duckduckgo.uservoice.com) from our user base.
 
In any case, we hope that you will consider helping to make some DuckDuckGo plugins. Here's why you might want to:

* Improve results in areas you personally search and care about, e.g. [programming documentation](https://duckduckgo.com/?q=perl+split), [gaming](https://duckduckgo.com/?q=roll+3d12+%2B+4) or [entertainment](https://duckduckgo.com/?q=xkcd).
* Increase usage of your own projects, e.g. [APIs](https://duckduckgo.com/?q=cost+of+living+nyc+philadelphia).
* Learn something new, e.g. more Perl or JavaScript.
* See your code live on a [growing](https://duckduckgo.com/traffic.html) search engine!

### Plugin types

DuckDuckGo plugins are like browser extensions, but for a search engine. There are four types of DuckDuckGo plugins:

1. **Goodies**. Example: [reverse test](https://duckduckgo.com/?q=reverse+test). The core of these plugins are self-contained Perl functions that generate instant answers (server-side).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). The core of these plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external [JSONP](https://duckduckgo.com/?q=jsonp) API calls (client-side).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). The core of these plugins are data files based on APIs, web-crawling, or existing databases that we put in our own databases and show instant answers based on slightly fuzzy keyword matching.

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). The core of these plugins are data files based on APIs, web-crawling or existing databases that we put in our own databases and show instant answers based on full-text indexing.

### A plugin line-by-line

We'll now walk through a complete Goodie plugin line-by-line. The following is the full code block that works on the query [chars test](https://duckduckgo.com/?q=chars+test) and returns the number of characters that make up the query (after the trigger word _chars_). Don't worry about not getting it all yet!


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

DuckDuckGo plugins are defined in Perl, though we've constructed the system to be as condensed and intuitive as possible. As a result, it may not look like any Perl you've seen before. Additionally, the meat of the plugin may not be in Perl at all (see Plugin types).

At the highest level, the plugin system works like this:

* We break the query (search terms) into words. This process happens in the background.

* We see if any of those words are **triggers** (trigger words). These are provided by each of the plugins. In the example, the trigger word is **chars**.

* If a Goodie is triggered, we run its **handle** function.

* If the Goodie's handle function outputs an instant answer via a **return** statement, we pass it back to the user.

Now let's take this Goodie line-by-line. Feel free to open a text editor and type an example along with us or look in the [Goodies repository](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/lib/DDG/Goodie) and follow along with an example there. Later, we'll show you how to test it.

Each plugin is a [Perl package](https://duckduckgo.com/?q=perl+package), so we start by declaring the package namespace.

```perl
package DDG::Goodie::Chars;
# ABSTRACT: Give the number of characters (length) of the query.
```

You would change **Chars** to the name of your plugin (written in [CamelCase](https://duckduckgo.com/?q=camelcase) format). 

You can probably guess that # denotes a comment. _# ABSTRACT:_ is a special comment line that gets parsed automatically by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla) to make nice documentation.

Next we have a [use statement](https://duckduckgo.com/?q=perl+use) that imports [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system into the local namespace (in this case, the Goodie system).

```perl
use DDG::Goodie;
```

Then we see the **triggers** keyword that specifies on which queries the Goodie operates. Think of triggers as _trigger words_. We take the query and break it up into words and then use those words to _trigger_ DuckDuckGo plugins. 

```perl
triggers start => 'chars';
```

In this case there is one trigger word, **chars**. In a query like _chars test_, chars is the first word so it would trigger our Goodie. The **start** keyword says, "Make sure the trigger word is at the start of the query". The => symbol is there to separate the trigger words from the keywords (for readability).

Once your triggers are specified, you define how to **handle** the query; _handle_ is another keyword. Like triggers, handle takes a second keyword, this time explaining what to handle.

```perl
handle remainder => sub {
```

You can _handle_ different pieces of the query, but the most common is the **remainder**, which refers to the rest of the query (everything but the triggers). For example, if the query was _chars test string_, the trigger would be _chars_ and the remainder would be _test string_. 

The right side of the statement (after the =>) is a function, denoted by the sub {} construction.

```perl
handle remainder => sub {
    return length $_ if $_;
    return;
};
```

This function is the meat of the Goodie; it generates the instant answer (if any). Whatever you are handling is passed to the function in the $_ variable (e.g. _test string_ if the query was _chars test string_).



If you can produce a useful instant answer you just **return** it. 

```perl
return length $_ if $_;
```

In this case, the heart of the function is just this one line. The remainder is in the $_ variable. If it is not blank (**if $_**), we return the number of chars using Perl's built-in [length function](https://duckduckgo.com/?q=perl+length).

Perl has a lot of built-in functions, as well as thousands and thousands of modules available [via CPAN](https://metacpan.org/). You can leverage these modules when making Goodies, like how the [Roman Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Roman.pm) uses the [Roman module](https://metacpan.org/module/Roman).

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

### Creating your first plugin step-by-step

**Step 1.** Decide what you want to work on. If you don't have any ideas, [start here](https://duckduckgo.uservoice.com/).

**Step 2.** Figure out what type of plugin is best for your idea (see Plugin types). It's probably a Goodie (like in the line-by-line example) or a Spice (using a JavaScript API). If it's not obvious, please [discuss it with us](http://webchat.freenode.net/?channels=duckduckgo). If you got your plugin idea from the [suggestion list](https://duckduckgo.uservoice.com/), most are tagged with what we think would be the appropriate type.

**Step 3.** Get a [GitHub account](https://github.com/) if you don't have one already. We use GitHub [to host](https://github.com/duckduckgo) all of our open-source code.

**Step 4.** If you haven't already, set-up git on your computer. GitHub provides instructions for [Linux](http://help.github.com/linux-set-up-git/), [OSX](http://help.github.com/mac-set-up-git/), and [Windows](http://help.github.com/win-set-up-git/) (though Linux is preferred since that is what we use for development).

**Step 5.** Fork the right repository (depending on your plugin type). If you've never forked a repository before, follow the [GitHub instructions](http://help.github.com/fork-a-repo/). Here are the links to the repositories:

 * [Goodies](https://github.com/duckduckgo/zeroclickinfo-goodies) (Perl functions)

 * [Spice](https://github.com/duckduckgo/zeroclickinfo-spice) (JavaScript functions)

 * [Fathead](https://github.com/duckduckgo/zeroclickinfo-fathead) (Keyword data)

 * [Longtail](https://github.com/duckduckgo/zeroclickinfo-longtail) (Full-text data)

You may also want to [watch the repo](http://help.github.com/be-social/) while you're at it.

**Step 6a.** If you are making a Goodie or Spice plugin run our install script; if not, skip to step 6f.

```sh
curl http://duckpan.org/install.pl | perl

 ____             _    ____             _     ____
|  _ \ _   _  ___| | _|  _ \ _   _  ___| | __/ ___| ___
| | | | | | |/ __| |/ / | | | | | |/ __| |/ / |  _ / _ \
| |_| | |_| | (__|   <| |_| | |_| | (__|   <| |_| | (_) |
|____/ \__,_|\___|_|\_\____/ \__,_|\___|_|\_\\____|\___/
=========================================================
```

This will set-up [local::lib](https://metacpan.org/module/local::lib), which is a way to install Perl modules without changing your base Perl installation (if you already use local::lib or [perlbrew](https://metacpan.org/module/perlbrew), don't worry, this script will intelligently use what you already have). It will also install all of the dependencies needed to run [App::DuckPAN](https://metacpan.org/module/duckpan), our plugin utility. 

If you didn't have a local::lib before running the install script, you will need to log-out, log-in, and re-run the script. It should tell you to do so like this:

```txt
local::lib (or perlbrew) is not active. If you ran this script for the first time, 
please now re-login to your user account and run it again!
```

If everything works, you should see this at the end:

```sh
EVERYTHING OK! You can now go hacking! :)
```

With local::lib installed, you can easily install perl modules with the cpanm command.

```sh
cpanm App::DuckPAN
App::DuckPAN is up to date. 
```

**Step 6b.** Go to your fork of the repository.

```sh
cd zeroclickinfo-goodies/
```

**Step 6c.** Install the distribution requirements.

Most modern Perl developers use a distribution manager called [Dist::Zilla](http://dzil.org/) which is useful for generating ready to distribute Perl distributions. Perl uses what's called a "toolchain" to ensure the installation of the distribution. Dist::Zilla covers the generation of the required files for a distribution, so we can install it with any CPAN client and concept. To use the modules inside the **zeroclickinfo-goodies** repository, we need to install their requirements, listed in **dist.ini**. Dist::Zilla now offers a program, **dzil**, which works with this file to supply us with the required information which we can then pipe to cpanminus:

```sh
dzil authordeps --missing | cpanm
dzil listdeps --missing | cpanm
```

The **authordeps** command will find the required Dist::Zilla plugins used in this distribution. Once those are installed, the **listdeps** command tells us the Perl modules required for **zeroclickinfo-goodies**.

**Step 6g.** Test all the goodies.

```sh
duckpan goodie test
```

This will output all of the plugins available in your repo (including the one you're working on) and switch you to an interactive mode where you can enter queries and see the results. For Spice plugins, you will want to do additional testing (see the Spice section below).

Once your plugin is working, go to Step 7.

**Step 6h.** If you're working on a Fathead or Longtail plugin, see the repository Readme for further details on how to format your plugin. We're still in the process of converting these plugin types to the new system.

**Step 7.** Commit your changes and push your forked repository back to GitHub. 

```sh
git commit -a -m "My first plugin is ready to go!"
git push
```

**Step 8.** Go into GitHub and submit a [pull request](http://help.github.com/send-pull-requests/)! That will let us know about your plugin and start the conversation about integrating it into the live search engine.


### Spice

Spice plugins are a bit different than Goodie plugins in that their central functions (to generate the instant answers) are done in JavaScript instead of Perl. There are a few extra steps needed to reference and test this JavaScript.

***TODO: walk through xkcd plugin when converted***


### Guidelines

The instant answers returned by plugins appear at the top of search results pages, which is the most valuable real estate on the page. As such, we have these guidelines about what should and should not be there.

**Better than links.** Since instant answers are above the traditional links, they should be unambiguously better than them.

**No false positives.** A false positive is an irrelevant instant answer. For example, suppose there was a plugin that triggered on the word amazon and showed information from Amazon.com. If someone typed in Amazon River, they likely would not want information from that plugin. We have systems in place to automatically weed out cases like this one, but you should be careful to only return an instant answer when you know it is good, and otherwise return nothing.

**Minimize vertical space.** We try to keep the instant answer box as small as possible, which generally means leaving out extraneous information. We try to put the most important information in the box, and then offer the user to click through to another page for more detailed information.

**Readable answers.** The instant answer area is supposed to make inherent sense, as opposed to the snippets in traditional links, which may or may not be actually readable. Generally the way we achieve this is create sentences or short statements that users can actually read. A good technique is to read your answers out loud and see if they make sense to someone else.

**Consistent design.** When in doubt, copy what already exists!

### Advanced plugin techniques

Here are some relatively common things that plugins may require.

**Multiple trigger words**. For example, suppose you thought that in addition to _chars_, _numchars_ should also trigger the [chars goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Chars.pm). You would simply add the extra trigger words.

```perl
triggers start => 'chars', 'numchars';
```

**Trigger locations.** As mentioned, the keyword after triggers, **start** in the Chars example, specifies where the triggers need to appear. Here are the choices:

* start - just at the start of the query
* end - just at the end of the query
* startend - at either end of the query
* any - anywhere in the query

**Further qualifying the query.** Trigger words are blunt instruments; they may send you queries you cannot handle. As such, you generally need to further qualify the query (and return nothing in cases where the query doesn't really qualify for your goodie).

There are number of techniques for doing so. For example, the first line of [Base Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Base.pm) has a return statement paired with unless.

```perl
return unless  /^([0-9]+)\s*(?:(?:in|as)\s+)?(hex|hexadecimal|octal|oct|binary|base\s*([0-9]+))$/;
```

You could also do it the other way, like the [GoldenRatio Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GoldenRatio.pm).

```perl
if ($input =~ /^(?:(?:(\?)\s*:\s*(\d+(?:\.\d+)?))|(?:(\d+(?:\.\d+)?)\s*:\s*(\?)))$/) {
```

Another technique is to use a hash to allow specific query strings, as the [GUID Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GUID.pm) does.

```
return unless exists $guid{$_};
```

In rare cases, trigger words don't work at all, e.g. when you need to trigger on sub-words. In those cases, instead of using trigger words you can trigger on a regular expression, like the [PrivateNetwork Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/PrivateNetwork.pm).

**Handling the whole query.** In the Chars example, we handled the **remainder**. You can also handle:

* query_raw - the actual (full) query
* query - with extra whitespace removed
* query_parts - like query but given as an array of words
* query_nowhitespace - with whitespace totally removed
* query_nowhitespace_nodash - with whitespace and dashes totally removed

For example, the [Xor Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Xor.pm) handles query_raw and the [ABC Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/ABC.pm) handles query_parts.

**Returning html**. Goodies return text instant answers by default, but could return simple html as well. In that case, simply attach the html version to the end of the return statement.

```perl
return $text, html => $html
```

**Other zci keywords**. The Chars example set the **is_cached** zci keyword. You can find other settable attributes in the [object documentation](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo). For example, the [GoldenRatio Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GoldenRatio.pm) sets the **answer_type** variable, which gets returned in the API.

```perl
zci answer_type => "golden_ratio";
```

**Using files**. You can use simple text/html input files for display or processing. To do so, you want to add a couple of modules to the top of your plugin.

```perl
use File::ShareDir::ProjectDistDir;
use IO::All;
```

Then, inside your handle function, you can read the file.

```perl
my $sharedir = dist_dir('zeroclickinfo-goodies');
my $lines = io("$sharedir/privatenetwork/privatenetwork.html")->slurp;
```

The [Passphrase Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Passphrase.pm) does this for processing purposes and the [PrivateNetwork Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/PrivateNetwork.pm) does it for display purposes.


### Frequently Asked Questions

1. **What if I don't know Perl?** If you don't know Perl, that's OK! First, the meat of the Spice, Fathead, and Longtail plugins do not have to be in Perl (Spice is JS and the others could be a variety of things). However, if you know PHP, Ruby, or Python you should be able to write Goodies in Perl pretty easily using [this awesome cheat sheet](http://hyperpolyglot.org/scripting) to help you in translating your psuedo-code to Perl.

2. **Can you help me?** Of course! Please join us on IRC at [#duckduckgo on Freenode](http://webchat.freenode.net/?channels=duckduckgo). You can also email us privately at open@duckduckgo.com.

3. **Do you have any plugin ideas?** Of course! Please check out [our uservoice site](http://duckduckgo.uservoice.com/) designed for this very purpose.

4. **Where I can report plugin pugs?** Please submit a GitHub issue in the [appropriate repository](http://github.com/duckduckgo).

5. **What if there are plugin conflicts?** The ultimate arbiter is the user, and that's the perspective we take, i.e. what is best for the user experience? That said, often times it makes sense to combine ideas into one, better plugin.

6. **Can I do something more complicated?** Maybe. There are a bunch more internal interfaces we haven't exposed yet, and we'd love to hear your ideas to influence that roadmap.