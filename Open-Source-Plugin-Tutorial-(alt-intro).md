Here’s how to make your own plugin for DuckDuckGo.

In this example, we’ll be making a plugin that checks the number of characters in a given search query.  The end result will look [like this](http://duckduckgo.com/?q=chars+how+many+characters+did+I+just+type%3F).   

Let's begin.  Open a plain-text editor such as [Gedit](http://projects.gnome.org/gedit/). 

Type the following: 

```perl
package DDG::Goodie::Chars;
# ABSTRACT: Give the number of characters (length) of the query.
```

Each plugin is a [Perl package](https://duckduckgo.com/?q=perl+package), so we start by declaring the package name. You would change **Chars** to the name of your plugin (written in [CamelCase](https://duckduckgo.com/?q=camelcase) format). 

The second line is a special comment that gets parsed automatically to make nice documentation (powered by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla)).

Next, type the following [use statement](https://duckduckgo.com/?q=perl+use) to import [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system.  In this example, we are making a Goodie (one of the four main DDG plugin types). 

```perl
use DDG::Goodie;
```

Now here's where it gets interesting.  Type: 

```perl
triggers start => 'chars';
```

**triggers** are keywords that initialize the Goodie.  Think of triggers as _trigger words_. When a particular trigger word is included in a given search query, it tells DuckDuckGo to _trigger_ the appropriate Goodie. 

In this case there is one trigger word, **chars**. Let's say someone searched _"chars this is a test"_. **chars** is the first word so it would trigger our Goodie. The **start** keyword says, "Make sure the trigger word is at the start of the query". The **=>** symbol is there to separate the trigger words from the keywords (for readability).

```perl
handle remainder => sub {
```

Once your triggers are specified, type in the above code to define how to _handle_ the query.  **handle** is another keyword, similar to triggers. 

You can _handle_ different pieces of the query, but the most common is the **remainder**, which refers to the rest of the query (everything but the triggers). For example, if the query was _"chars this is a test"_, the trigger would be **_chars_** and the remainder value would be _this is a test_. 

Now add another couple lines more to your function so it looks like this: 

```perl
handle remainder => sub {
    return length $_ if $_;
    return;
};
```

This function is the meat of the Goodie; it generates the instant answer. Whatever you are handling is passed to the function in the **$_** variable ($_ is Perl's favorite default variable; it is used commonly to store temporary values).  The value of **$_** will be whatever is being processed, as specified previously with **handle** (for example, if you searched DuckDuckGo for _"chars this is a test"_ the value of **$_** will be _this is a test_).

Let's take a closer look at the second line of the function. 

```perl
return length $_ if $_;
```
In this case, the heart of the function is just this one line. The **remainder** is in the **$_** variable. If it is not blank (**if $_**), we return the number of chars using Perl's built-in [length function](https://duckduckgo.com/?q=perl+length).

Perl has a lot of built-in functions, as well as thousands and thousands of modules available [via CPAN](https://metacpan.org/). You can leverage these modules when making Goodies, like how the [Roman Goodie](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Roman.pm) uses the [Roman module](https://metacpan.org/module/Roman).

Anyway, if we are unable to provide a good instant answer, we simply return nothing. You'll notice we did that if $_ didn't contain anything.

Now, below your function type in the following line. 

```perl
zci is_cached => 1;
```
This last line is optional.   Goodies technically return a [ZeroClickInfo object](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo) (abbreviated as zci).  We can override the default behavior of a Goodie with the **zci** keyword. 

We set **is_cached** to true (0 is false, 1 is true) because this Goodie will always return the same answer every time for a given query.   This speeds up future answers by caching (saving previous answers).

Finally, all Perl packages that load correctly should [return a true value](http://stackoverflow.com/questions/5293246/why-the-1-at-the-end-of-each-perl-package) so add a 1 on the very last line.  

```perl
1;
```

And that's it!  At this point your DDG plugin is complete.    The final result should look like this: 


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

The next part of this tutorial will give a higher level overview of the DuckDuckGo plugin system, including the other main types of DuckDuckGo Plugins. As well how to setup an environment to test your creation.  And finally, we'll explain how to upload it and get your plugin one step closer to running on the live DuckDuckGo.com search engine.  Exciting!