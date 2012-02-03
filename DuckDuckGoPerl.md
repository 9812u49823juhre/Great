# DuckDuckGo and Perl

## Our version of Perl

Right now, all we do on DuckDuckGo (so the search engine itself, the community platform and all additional services), is using Perl 5.10.1 as a base. In the near future we plan to upgrade to Perl 5.16 to bring the most recent speed advantages to our platform, but right now it's all Perl 5.10.1. This switch will not impact the development of the modules, because Perl 5.16 is compatible with Perl 5.10.1 (all Perl versions are backwards-compatible). This ensures that the switch will be very painless.

## DuckDuckGo Core and DuckDuckGo Community

At DuckDuckGo we try to use the best-fitting solutions for each problem we tackle. That's why we've split up our Perl development into 2 general paths: "Most Modern" and "Fastest." The "Most Modern" way is for the Community Platform and all other services that are not part of the core search engine implementation. This method ensures that we can bind in new services much faster and more far more easily. The "Fastest" way is the way we work on the search engine itself to ensure that we can answer the requests as fast as possible.

The main difference between the two is the usage of the object layer in those areas. For the "Most Modern" method we use [Moose](https://metacpan.org/module/Moose) as the object layer, which also gives us the power of a Meta layer and the option to use many of the brand-new solutions out there, like [Catalyst](http://www.catalystframework.org/). Also, we use [DBIx::Class](http://metacpan.org/module/DBIx::Class) as a layer to abstract the database in an object orientated, Perl-like way.

For the "Fastest" way on the core search engine, we use [Moo](https://metacpan.org/Moo) as the object layer, which gives us the core functions of Moose, but is still as fast as not using an object layer. This allows us to program the same way in both methods, with the simple caveat of having to think about the missing functions when using Moo and the "Fastest" method. However, most of these missing functions can be compensated for with a bit of extra code.

For more information about our object layers Moo and Moose, we suggest you visit our wiki page "[Working with Moo(se)](https://github.com/duckduckgo/duckduckgo/wiki/PerlOO)"

## Our distribution we use

## Our way of coding

## Git and Github

