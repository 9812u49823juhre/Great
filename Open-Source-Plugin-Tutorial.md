DuckDuckGo plugins react to search queries and provide useful instant answers above the traditional link results.

There are four types of plugins:

1. **Goodies**. Example: [reverse this query](https://duckduckgo.com/?q=reverse+this+query). These plugins are self-contained Perl functions that generate instant answers (server-side).

2. **Spice**. Example: [xkcd](https://duckduckgo.com/?q=xkcd). These plugins are self-contained JavaScript functions that generate instant answers based on objects returned from external JSONP API calls (client-side).

3. **Fathead**. Example: [git branch](https://duckduckgo.com/?q=git+branch). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on slightly-fuzzy keyword matching.

4. **Longtail**. Example: [snow albedo](https://duckduckgo.com/?q=snow+albedo). These plugins produce stand-alone data files based on APIs, web-crawling or existing databases and show instant answers based on full-text indexing.

Goodies and Spice plugins are really easy to make (explained below). Fathead and Longtail plugins are still being converted to this new easy system. If you'd like to work on Fathead (feel free!), check out [this readme](https://github.com/duckduckgo/zeroclickinfo-fathead). For Longtail, please contact us at open@duckduckgo.com.

### Goodies

Here's the code for the reverse Goodie example above.

```perl
package DDG::Goodie::Reverse;
# ABSTRACT: Reverse the order of chars in the remainder

use DDG::Goodie;

triggers startend => 'reverse';

handle remainder => sub { 
  my $remainder = $_;
  my @chars = split(//,$remainder);
  @chars = reverse @chars;
  my $answer = join('',@chars); 
  return $answer;
};

zci is_cached => 1;

1;
```

Even if you don't know any Perl, Goodies should still be easy to make. Let's take each block in turn.

```perl
package DDG::Goodie::Reverse;
# ABSTRACT: Reverse the order of chars in the remainder
```

First define a Perl package for your Goodie, which we will import into our back-end. You would change **Reverse** to your name (CamelCase). 

You probably guessed # lines are comments. # ABSTRACT: is a special comment line that gets automatically parsed by [Dist::Zilla](https://metacpan.org/module/Dist::Zilla) to make nice documentation.

Next we have a [use statement](https://duckduckgo.com/?q=perl+use) that imports [the magic behind](https://github.com/duckduckgo/duckduckgo/tree/master/lib/DDG) our plugin system into the local namespace.

```perl
use DDG::Goodie;
```

Then we see the triggers keyword that specifies on what queries the Goodie operates. Think of triggers as **trigger words**. We take the query and break it up into words and then use those words to trigger the Goodies. 

```perl
triggers startend => 'reverse';
```

You can use multiple trigger words.

```perl
triggers start => 'capitalize', 'uppercase';
```

You also specify where those words need to appear:
* start - just at the start of the query
* end - just at the end of the query
* startend - at either end of the query
* any - anywhere in the query

Once triggers are specified you then define how to **handle** the query, which is another keyword. 

```perl
handle remainder => sub { 
  my $remainder = $_;
  my @chars = split(//,$remainder);
  @chars = reverse @chars;
  my $answer = join('',@chars); 
  return $answer;
}
```

**remainder** is one of the things you can handle, and refers to the remainder of the query (everything but the triggers). For example, if the query was reverse this query, the trigger would be _reverse_ and so the remainder would be _this query_. 

Whatever you are handling is passed to the function as $_. You can also handle:
* query_raw 
* query
* query_nowhitespace
* query_nowhitespace_nodash

If you are unable to provide a good instant answer, you can simply return nothing and short-circuit.

```perl
return;
```

If you can produce a useful instant answer you just return it as one Scalar (as opposed to an Array, ArrayRef or HashRef). 

```perl
zci is_cached => 1;
```

```perl
1;
```