# DuckDuckGo and Perl

## Our version of Perl

Right now, all we do on DuckDuckGo (so the search engine itself, the community platform and all additional services), is using Perl 5.10.1 as base. In the near future we want to upgrade to Perl 5.16 to bringup the most recent speed advantages to our platform, but right now its all Perl 5.10.1 and will stay on this only we start planning to change this. It will anyway not impact the development of the modules, because Perl 5.16 is compatible to Perl 5.10.1 like all Perl versions are backward compatible. This way it assures that the switch will be very painless.

## DuckDuckGo Core and DuckDuckGo Community

On DuckDuckGo we try to use the most fitting solutions for the problem. Thats why we have splitted up our Perl development into 2 general paths: "Most Modern" and "Most Fast", to put it into easy words. The "Most Modern" way is the way of the Community Platform and all services which are not part of the core search engine abilities. This way we assure that we can use the most modern methods here and bind in new services much faster and much more easy. The "Most Fast" way is the way we work on the search engine itself, to assure that we can answer the requests in as fast as possible.

The main difference out of this is the usage of the object layer we use in those areas. On the "Most Modern" way we use [Moose](https://metacpan.org/module/Moose) as object layer, which gives us also the power of a Meta layer, and gives us the options to use many of the most modern solutions out there, like [Catalyst](http://www.catalystframework.org/). Also we use [DBIx::Class](http://metacpan.org/module/DBIx::Class) as layer to abstract the database in a object orientated Perl like way.

On the core search engine, on the "Most Fast" way, we use [Moo](https://metacpan.org/Moo) as object layer, which gives us most important functions of Moose, but still is as fast as not using an object layer at all. This advantage allows us to code in both ways the same way, and just need to think about some "missing options" in the fast way, which normally can be compensated with a bit more code (or usage of other concepts).

For more information about our object layers Moo and Moose, we suggest you our wiki page "[Working with Moo(se)](https://github.com/duckduckgo/duckduckgo/wiki/PerlOO)"

## Our distribution we use

## Our way of coding

## Git and Github

