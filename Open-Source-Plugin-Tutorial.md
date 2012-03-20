DuckDuckGo plugins react to search queries and provide [useful](https://duckduckgo.com/?q=%40duckduckgo) [instant](https://duckduckgo.com/?q=roman+xvi) [answers](https://duckduckgo.com/?q=private+ips) above traditional links. 

### A plugin line-by-line

In this tutorial, we'll be making a plugin that checks the number of characters in a given search query. Then end result will look [like this](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Length.pm) and works [like this](https://duckduckgo.com/?q=chars+How+many+characters+are+in+this+sentence%3F). It's in Perl though the meat of some plugin types can be written in other languages (see Plugin types).

Let's begin. Open a text editor like [gedit](http://projects.gnome.org/gedit/), notepad or [emacs](http://www.gnu.org/software/emacs/) and type the following.

```perl
package DDG::Goodie::Chars;
# ABSTRACT: Give the number of characters (length) of the query.
```

Each plugin is a [Perl package](https://duckduckgo.com/?q=perl+package), so we start by declaring the package namespace. In a new plugin, you would change **Chars** to the name of the new plugin (written in [CamelCase](https://duckduckgo.com/?q=camelcase) format). 

The second line is a special comment line that gets parsed automatically to make nice documentation (by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla)).

Next, type the following [use statement](https://duckduckgo.com/?q=perl+use) to import [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system. In this example we are making a Goodie (one of four DuckDuckGo plugin types defined later).

```perl
use DDG::Goodie;
```

Now here's where it gets interesting. Type:

```perl
triggers start => 'chars';
```

**triggers** are keywords that tell us when to make the Goodie run. They are _trigger words_. When a particular trigger word is part of a search query, it tells DuckDuckGo to _trigger_ the appropriate plugins. 

In this case there is one trigger word, **chars**. Let's say someone searched "_chars this is a test_." **chars** is the first word so it would trigger our Goodie. The **start** keyword says, "Make sure the trigger word is at the start of the query." The **=>** symbol is there to separate the trigger words from the keywords (for readability).

Now type in this line:

```perl
handle remainder => sub {
```

Once triggers are specified, we define how to _handle_ the query. **handle** is another keyword, similar to triggers.

You can _handle_ different aspects of the search query, but the most common is the **remainder**, which refers to the rest of the query (everything but the triggers). For example, if the query was "_chars this is a test_", the trigger would be _chars_ and the remainder would be _this is a test_. 

Now add another couple of lines to complete the handle function.

```perl
handle remainder => sub {
    return length $_ if $_;
    return;
};
```

This function (the part within the **{}** after **sub**) is the meat of the Goodie. It generates the instant answer that is displayed at the top of the [search results page](https://duckduckgo.com/?q=chars+this+is+a+test). 

Whatever you are handling is passed to the function in the **$_** variable (**$_** is a special default variable in Perl that is commonly used to store temporary values). For example, if you searched DuckDuckGo for "_chars this is a test_", the value of **$_** will be "_this is a test_", i.e. the remainder.

Let's take a closer look at the first line of the function.

```perl
return length $_ if $_;
```

The heart of the function is just this one line. The **remainder** is in the **$_** variable as discussed. If it is not blank (**if $_**), we return the number of chars using Perl's built-in [length function](https://duckduckgo.com/?q=perl+length).

Perl has a lot of built-in functions, as well as thousands and thousands of modules available [via CPAN](https://metacpan.org/). You can leverage these modules when making Goodies, like how the [Roman Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Roman.pm) uses the [Roman module](https://metacpan.org/module/Roman).

If we are unable to provide a good instant answer, we simply **return** nothing. And that's exactly what the second line in the function does.

```perl
return;
```

This line is only run if **$_** contained nothing, because otherwise the line before it would return something and end the function.

Now, below your function type the following line.

```perl
zci is_cached => 1;
```

This line is optional. Goodies technically return a [ZeroClickInfo object](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo) (abbreviated as **zci**). This effect happens transparently by default, but you can override this default behavior via the **zci** keyword.

We set **is_cached** to true (0 is false, 1 is true) because this plugin will always return the same answer for the same query. This speeds up future answers by caching them, i.e. saving previous answers. 

Finally, all Perl packages that load correctly should [return a true value](http://stackoverflow.com/questions/5293246/why-the-1-at-the-end-of-each-perl-package) so add a 1 on the very last line.

```perl
1;
```

And that's it! A this point you have a working DuckDuckGo Goodie plugin. It should look like this:

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

To review, the plugin system works like this at the highest level:

* We break the query (search terms) into words. This process happens in the background.

* We see if any of those words are **triggers** (trigger words). These are provided by each of the plugins. In the example, the trigger word is **chars**.

* If a Goodie is triggered, we run its **handle** function.

* If the Goodie's handle function outputs an instant answer via a **return** statement, we pass it back to the user.


### Why plugins?

We made the DuckDuckGo plugin system because we strongly believe that (relevant) instant answers provide a much better search experience than traditional (link) results. As such, we'd love to show them for as many search queries as possible.

We're not knowledgeable about every subject, e.g. bioinformatics, nor do we have the resources to develop plugins for niche search areas, e.g. lego parts. Yet we know there could be great instant answers in those areas and thousands of others! 

That's where you come in. You may know enough about certain search areas to help develop plugins for those areas. We also have an ever-increasing list of [plugin suggestions](http://duckduckgo.uservoice.com) from DuckDuckGo users.
 
In any case, we hope that you will consider helping to make some DuckDuckGo plugins. Here's why you might want to:

* Improve results in areas you personally search and care about, e.g. [programming documentation](https://duckduckgo.com/?q=perl+split), [gaming](https://duckduckgo.com/?q=roll+3d12+%2B+4) or [entertainment](https://duckduckgo.com/?q=xkcd).
* Increase usage of your own projects, e.g. [APIs](https://duckduckgo.com/?q=cost+of+living+nyc+philadelphia).
* Learn something new, e.g. more Perl or JavaScript.
* See your code live on a [growing](https://duckduckgo.com/traffic.html) search engine!

### Plugin types

DuckDuckGo plugins are defined in [Perl](https://duckduckgo.com/Perl), though we've constructed the system to be as condensed and intuitive as possible. As a result, it may not look like any Perl you've seen before. Additionally, the meat of the plugin may not be in Perl at all.

There are four types of DuckDuckGo plugins:

1. **Goodies**. Example: [reverse test](https://duckduckgo.com/?q=reverse+test). The core of these plugins are self-contained Perl functions that generate instant answers (server-side). [Goodie repository](https://github.com/duckduckgo/zeroclickinfo-goodies). [Goodie suggestions](https://duckduckgo.uservoice.com/forums/5168-plugins/category/41841-goodies).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). The core of these plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external [JSONP](https://duckduckgo.com/?q=jsonp) API calls (client-side). [Spice repository](https://github.com/duckduckgo/zeroclickinfo-spice). [Spice suggestions](https://duckduckgo.uservoice.com/forums/5168-plugins/category/41838-spice).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). The core of these plugins are data files based on APIs, web-crawling, or existing databases that we put in our own databases and show instant answers based on slightly fuzzy keyword matching. [Fathead repository](https://github.com/duckduckgo/zeroclickinfo-fathead). [Fathead suggestions](https://duckduckgo.uservoice.com/forums/5168-plugins/category/41839-fathead).

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). The core of these plugins are data files based on APIs, web-crawling or existing databases that we put in our own databases and show instant answers based on full-text indexing. [Longtail repository](https://github.com/duckduckgo/zeroclickinfo-longtail). [Longtail suggestions](https://duckduckgo.uservoice.com/forums/5168-plugins/category/41840-longtail).

### Submitting your first plugin step-by-step

**Step 1.** Decide what you want to work on. If you don't have any ideas, [start here](https://duckduckgo.uservoice.com/).

**Step 2.** Figure out what type of plugin is best for your idea (see Plugin types). It's probably a Goodie (like in the line-by-line example) or a Spice (similar, but in JavaScript and using an API from another site for data). If it's not obvious, please [discuss it with us](http://webchat.freenode.net/?channels=duckduckgo). If you got your plugin idea from the [suggestion list](https://duckduckgo.uservoice.com/), many are tagged with what we think would be the appropriate type (see tag filter links on the right sidebar).

**Step 3.** Get a [GitHub account](https://github.com/) if you don't have one already. We use GitHub [to host](https://github.com/duckduckgo) all of our open-source code.

**Step 4.** If you haven't already, set-up git on your computer. GitHub provides instructions for [Linux](http://help.github.com/linux-set-up-git/), [OSX](http://help.github.com/mac-set-up-git/), and [Windows](http://help.github.com/win-set-up-git/). We use Linux for development, so we strongly encourage development of DuckDuckGo plugins in a Linux environment. We can't guarantee the following steps will work on other platforms. If you don't have Linux, some easy solutions that allow you to keep your current environment are to set up a virtual machine using [VirtualBox](https://www.virtualbox.org/) or [VMWare](http://www.vmware.com/products/player/), or use a free micro-instance on [Amazon Web Services](http://aws.amazon.com/free/).

**Step 5.** Fork the right repository (depending on your plugin type). If you've never forked a repository before, follow the [GitHub instructions](http://help.github.com/fork-a-repo/). Here are the links to the repositories:

 * [Goodies](https://github.com/duckduckgo/zeroclickinfo-goodies) (Perl functions)

 * [Spice](https://github.com/duckduckgo/zeroclickinfo-spice) (JavaScript functions)

 * [Fathead](https://github.com/duckduckgo/zeroclickinfo-fathead) (Keyword data)

 * [Longtail](https://github.com/duckduckgo/zeroclickinfo-longtail) (Full-text data)

You may also want to [watch these repositories](http://help.github.com/be-social/) while you're at it.

**Step 6a.** If you are making a Goodie or Spice plugin run our install script; if not, skip to step 6h.

```sh
curl http://duckpan.org/install.pl | perl
```

This will set-up [local::lib](https://metacpan.org/module/local::lib), which is a way to install Perl modules without changing your base Perl installation. If you already use local::lib or [perlbrew](https://metacpan.org/module/perlbrew), don't worry, this script will intelligently use what you already have. It will also install [duckpan](https://metacpan.org/module/duckpan), our plugin utility. 

If you didn't have a local::lib before running the install script, you will need to run the script twice. It should tell you when like this:

```txt
local::lib (or perlbrew) is not active. If you ran this script for the first time, 
please now re-login to your user account and run it again!
```

If everything works, you should see this at the end:

```sh
EVERYTHING OK! You can now go hacking! :)
```

Note that with local::lib now installed, you can easily install [Perl modules](http://search.cpan.org/) with the cpanm command.

```sh
cpanm App::DuckPAN
App::DuckPAN is up to date. 
```

**Step 6b.** Go to your fork of the repository (a directory or folder on your computer). The fork directory should have been created when you forked the repository in Step 5.

```sh
cd zeroclickinfo-goodies/
```

**Step 6c.** Install the repository requirements using duckpan, a utility that was installed as part of Step 6a (install script) and is part of [App::DuckPAN](https://metacpan.org/module/App::DuckPAN).

```txt
duckpan installdeps
```

This command will install all the Perl modules used by the DuckDuckGo plugins within your local repository. These requirements are defined in the [_dist.ini_ file](http://blog.urth.org/2010/06/walking-through-a-real-distini.html) at the root of the repository.

**Step 6d.** Add your plugin.

Make a new file in the **lib/DDG/Goodie/** directory for Goodies or the **lib/DDG/Spice/** directory for Spice. The name of the file is the name of the plugin followed by the extension **.pm** because it is a Perl package. For example, if the name of your plugin was _TestPlugin_, the file would be _TestPlugin.pm_. 

**Step 6e.** Test your plugin interactively.

Type this command at the command line.

```txt
duckpan goodie test
```

This command will first output all of the plugins available in your local plugin repository.

```md
Using the following DDG::Goodie plugins:

 - DDG::Goodie::Xor (Words)
 - DDG::Goodie::SigFigs (Words)
 - DDG::Goodie::EmToPx (Words)
 - DDG::Goodie::Length (Words)
 - DDG::Goodie::ABC (Words)
 - DDG::Goodie::Chars (Words)
 ...
```

You should see your plugin in there as well. When that output is finished it gives you an interactive prompt.

```
(Empty query for ending test)
Query:
```

Now you can type in any query and see what the response will be.

```
Query: chars this is a test

DDG::ZeroClickInfo  {
    Parents       WWW::DuckDuckGo::ZeroClickInfo
    Linear @ISA   DDG::ZeroClickInfo, WWW::DuckDuckGo::ZeroClickInfo, Moo::Object
    public methods (3) : is_cached, new, ttl
    private methods (0)
    internals: {
        answer   14,
        answer_type   "chars",
        is_cached   1
    }
}
```

There is a lot of debugging output, but you will want to pay special attention to the internals section.

```txt
    internals: {
        answer   14,
        answer_type   "chars",
        is_cached   1
    }
```

Here you can see the answer returned, as well as any **zci** keywords (by default there will be a default **answer_type** and **is_cached** value).

For Spice plugins, you will want to do additional testing (see the Spice section below).

Simply hit enter (a blank query) to exit interactive mode.

```txt
Query:

\_o< Thanks for testing!
```

**Step 6f.** Add your plugin test file.

Now make a new file in the test directory **t/**. The name of the file is again the name of your plugin, but this time followed by the extension **.t** for test because it is a Perl testing file. For example, if the name of your plugin was _TestPlugin_, the file would be _TestPlugin.t_.

The top of the file reads like a normal Perl script with some use statements to include testing modules, including the DuckDuckGo testing module.

```perl
#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;
```

Then you define any default **zci** values that you set, which you want to make sure are set right.

```perl
zci answer_type => 'chars';
zci is_cached => 1;
```

These should match exactly what you set in your **.pm** file.

Next comes the actual testing function.

```
ddg_goodie_test(
        [qw(
                DDG::Goodie::Chars
        )],
        'chars test' => test_zci('4'),
        'chars this is a test' => test_zci('14'),
);
```

For each test, you include a line like this:

```perl
        'chars test' => test_zci('4'),
```

The first part, **'chars test'** in this example, is the test query. The second part, **test_zci('4')** calls the test function and looks for **4** within the answer.

Finally you end a testing file with this line.

```perl
done_testing;
```

The full file should look like this:

```perl
#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'chars';
zci is_cached => 1;

ddg_goodie_test(
        [qw(
                DDG::Goodie::Chars
        )],
        'chars test' => test_zci('4'),
        'chars this is a test' => test_zci('14'),
);

done_testing;
```


**Step 6g.** Test your plugin programmatically.

Run your plugin test file like this:

```txt
perl -Ilib t/Chars.t
```

If successful, you should see a lot of **ok** lines.

```txt
ubuntu@yegg:~/zeroclickinfo-goodies$ perl -Ilib t/Chars.t
ok 1 - Testing query chars test
ok 2 - Testing query chars this is a test
1..2
```

If unsuccessful, you will see one or more **not ok** lines followed with some debugging output to help you chase down the error(s).

```txt
ok 1 - Testing query chars test
not ok 2 - Testing query chars this is a test
#   Failed test 'Testing query chars this is a test'
#   at /usr/local/ddg.cpan/perl5/lib/perl5/DDG/Test/Goodie.pm line 69.
#     Structures begin differing at:
#          $got->{answer} = '14'
#     $expected->{answer} = '15'
1..2
# Looks like you failed 1 test of 2.
```

If everything looks good, you're all set! Move onto **Step 7.**

**Step 6h.** If you're working on a Fathead or Longtail plugin, see the repository Readme for further details on how to format your plugin. We're still in the process of converting these plugin types to the new (duckpan) system.

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

**Consistent design.** When in doubt, copy what already exists! If still in doubt, [ask us](http://webchat.freenode.net/?channels=duckduckgo)!

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

4. **Where I can report plugin bugs?** Please submit a GitHub issue in the [appropriate repository](http://github.com/duckduckgo).

5. **What if there are plugin conflicts?** The ultimate arbiter is the user, and that's the perspective we take, i.e. what is best for the user experience? That said, often times it makes sense to combine ideas into one, better plugin.

6. **Can I do something more complicated?** Maybe. There are a bunch more internal interfaces we haven't exposed yet, and we'd love to hear your ideas to influence that roadmap.