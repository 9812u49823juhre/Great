# Zero-click Info Developer API v2 Beta Test Information Page

We suggest that you have Perl knowledge here. This is semi public, all Beta, please get in contact with us on IRC before doing stuff :).

## General organization

The internal organization of DuckDuckGo is very complex, and cant be fully revealed to the public, out of this situation, we decided to invent the so called _Block-Technology_ which is making it possible to groupe together Bangs, Goodies, Spice and Fathead Plugins over one concept.

This means: When the user gives a query on DuckDuckGo it will produce a [DDG::Request](https://github.com/duckduckgo/duckduckgo/blob/master/lib/DDG/Request.pm) like this:

```perl
my $request = DDG::Request->new( query_raw => $the_original_query );
```

Inside DuckDuckGo, this **$request** is passed through several Blocks, whoever matches can give a reply. Its a bit specific what you can give as reply, it depends on what type of Plugin you are, but we try to abstract that as easy as possible for you, as you will see the in the specific Zero-click Info Plugin type documentation.

### General informations about Block

Both kind of Blocks are started up the same way:

```perl
  my $a_block = DDG::Block::Words->new({
    plugins => [qw(
      DDG::Goodie::One
      DDG::Goodie::Two
      DDG::Goodie::Three
      DDG::Goodie::Four
    )],
  });
```

The order of the Plugins is always a priority order, depending on specific Block implementation, this is internal different. Important is only, whatever kind of Block it is, Regexp or Words, ::One would definitly match before ::Two, when both are fulfilling to match the query. 

### Instantiation of the Plugin inside the Block

A new plugin gets the Block itself as attribute parameter **block** given, and can of course prepare itself with a BUILD function or with attributes. 

```perl
my $plugin = DDG::Goodie::One->new( block => $a_block );
```

### Request to Block

To check if the query matches, the system will pass the **$request** object from the query, to the Block this way:

```perl
$a_block->request($request);
```

### What a Block suggests from a Plugin

Whatever Block it is, the Block will call the function **handle_request_matches** on the Plugin, what it gets depends on the specific plugin but the base in general is:

```perl
$plugin->handle_request_matches($request,@matches_or_pos);
```

Normally the developer doesnt need to handle this, cause we abstracted this in keywords, see later.

## Sample DDG::Goodie Plugin for DDG::Block::Words

```perl
package DDG::Goodie::Reverse;

use DDG::Goodie;

zci is_cached => 1;

words around => 'reverse';

handle remainder => sub { join('',reverse split(//,$_)) };

1;
```

### zci

This way you can define the general parameter of your Zero-click Info Plugin. Normally you dont need to set anything, we set automatically sane defaults for the required parameter. **is_cached** is here an exception, if your plugin is _unlimited_ cacheable (like in the case of the Reverse plugin, the reverse of the text of course never changes), it would be good if you set **is_cached** to one.

More information about possible attributes, you can find at [WWW::DuckDuckGo::ZeroClickInfo](https://metacpan.org/module/WWW::DuckDuckGo::ZeroClickInfo). Only the **is_cached** attribute is added through [DDG::ZeroClickInfo](https://github.com/duckduckgo/duckduckgo/blob/master/lib/DDG/ZeroClickInfo.pm). We also add **ttl** but this is not used yet.

You may give a HashRef to **zci**, to give several attributes at once.

### words

With words you can define the keywords for being used inside a [DDG::Block::Words](https://github.com/duckduckgo/duckduckgo/blob/master/lib/DDG/Block/Words.pm). We highly encourage using this method over the Regexp method which we explain later, cause this method is 10-100 times more efficient.

So far we support **any**, **before**, **after** and **around** as type for the words that trigger this plugin. You may give several **words** if you want, also with mixing types. **any** triggers if any of the query words matches any of the those words. **after** needs to be the last word in the query, **before** needs to be the first word in the query, and **around** is the same like given the word as **after** and **before**, so it triggers, when the query starts or ends with the specific word. Mostly you will use **around** if you make simple functional plugins.

Also here you may give a HashRef for the parameters. If you want to specify several words of the same type, you can group them as ArrayRef.

### handle

**handle** generates the required **handle_request_matches** function for you, depending on what you need to work inside the query. Here we do very massive Perl Blackmagic ;), so you shouldnt think too much how we make it happen (if you dislike this kind of Blackmagic you may do your own **handle_request_matches** function, as said in the overview. You can request all attributes of the given DDG::Request to be handled and in addition you can use **remainder** which is a special way to give you the "non matching" part of the query. This is what you mostly will want to work with. The value you request to handle will be given as **$_**.

Additional you can use **query_raw**, **query**, **query_nowhitespace**, **query_nowhitespace_nodash**. You can see how they are generated and put together in DDG::Request code.

Its important here that you only give back a ready string as one Scalar, not an Array, ArrayRef or HashRef.

### returning nothing

If your Plugin matches, but still is unable to provide a zeroclickinfo you must end with:

```perl
return;
```

## Sample DDG::Goodie Plugin for DDG::Block::Regexp

```perl
package DDG::Goodie::Reverse;

use DDG::Goodie;

zci is_cached => 1;

regexp qr/reverse\s(.*)/i, qr/(.*)\sreverse/i;

handle matches => sub { join('',reverse split(//,$_[0])) };

1;
```

### regexp

Instead of **words** you give here the regexp which should match against the query. You can also specify to match against other attributes of the query, but this is normally not necessary.

### handle

Regexp Plugins are not able to handle **remainder**, instead you get **matches**, which gives all the matches of the matching Regexp on **@_**. Parallel you can also access the raw query on **$_**.

## Best start

Checkout the [Block Test](https://github.com/duckduckgo/duckduckgo/blob/master/t/35-block.t) to get a nice base setup for making your own test.

If you want to make a distribution directly, please use Dist::Zilla and so far just upload them to your Github (or other repository hosting whatever you have) and show it to us that we can discuss it. We want to provide easy ways for making those (which are already in the work, so this block of text will change soon ;) ).