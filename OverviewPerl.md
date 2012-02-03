# Overview of Perl

## What is Perl?

Perl is a general purpose scripting language, which is often called "the glue of the internet". It is very flexible and powerful, and so it can be easily misused, which leads to a history with lots of misunderstandments, so, whatever you heard about Perl before, please forget it first, and start getting a feeling for the modern and new culture of Perl.

For getting a really complete overview of the current culture of Perl, we strongly suggest reading of the [free modern Perl book](http://www.onyxneon.com/books/modern_perl/) of Onyx Neon. But we will give a small overview of the most important things to know here, if you already know other languages and are aware of developing by itself.

At first its important to understand that even if Perl is a script language, many of the modules uses compiled C code, thats why you cant just copy together some Perl modules (the .pm files) and think this work. An installation of a Perl distribution is a specific process, which is covered by the so called toolchain. Every language has such a toolchain normally to make it possible to install extensions of any kind. It is always very important to not break this toolchain, so that people can assure they get installed like they should get installed. In Perl the advantage is that the language is so splitted up from the operating system, that you can nearly do anything completly in userspace, without touching your locally installed Perl in anyway. All you need todo for this documentations and tutorials can be done under a normal user account.

## Setup your development environment

So its very important that you first setup a little development environment, to play around sane with Perl. Here you can find the documentation: "[How to install your Perl development environment](https://github.com/duckduckgo/duckduckgo/wiki/PerlDevEnv)". Perl insist on using many modules, cause its the mission to not recode stuff that is already done, but they also dont shovel anything into the core, to let you have the freedom of choice. This gives many decision options to decide the path of coding. With the splitting of namespaces its even possible to combine several different coding styles in one huge codebase. You will see that when you are using it. Be aware that we only support and explain Perl development with Linux systems, prefered Debian or Ubuntu, cause those are the systems we use at DuckDuckGo.

## Learn Perl

When you are done with setting up the development environment, you actually can start learning Perl itself, cause without it you just limit yourself and get into awkward situations, already upgrade a module on the system perl could violate the complete integrity of your system distribution and could lead into serious damage to your system, so please be aware, that whatever you do, do it as user account. Only the bare minimum of Perl can be really learned without this development environment. A big overview of beginner tutorials for Perl can be found at "[Learn Perl](http://learn.perl.org)", but you can actually cover everything you need with the so called "[Perl Programming Documentation](http://perldoc.perl.org/)". This collection of Perl base documentations covers a [huge list of specific tutorials and reference manuals](http://perldoc.perl.org/perl.html#Tutorials).

What you minimum should read is the so called "[perlintro](http://perldoc.perl.org/perlintro.html)". It covers a quick overview, which COULD be enough to start your way into Perl (or to fresh up your own knowledge). But normally you will also read more tutorials from the above list, or specific reference manuals of Perl.

The references in a nutshell:

* [Language reference](http://perldoc.perl.org/index-language.html)

This documentation listing covers the language itself, the syntax, data structures, and all those things which let you understand how the interpreter works with the source code. Important here to read is [Operators](http://perldoc.perl.org/perlop.html) and [Special Variables](http://perldoc.perl.org/perlvar.html).

* [Perl functions A-Z](http://perldoc.perl.org/index-functions.html)

This listing covers all functions that are default available in Perl. Most of them you already know from other languages, probably its a good idea to browse through them :). Dont feel sad if something you need is not covered up, we will later come to the power of CPAN which reveals much more options.

* [Pragmas](http://perldoc.perl.org/index-pragmas.html)

...

* [Utilities](http://perldoc.perl.org/index-utilities.html)

Here you can find explaination of the tools and utilities which are delivered together with Perl. What you only need from here in nearly all cases is the documentation of [prove](http://perldoc.perl.org/prove.html), which is used to run tests in Perl.

* [Internals and C language interface](http://perldoc.perl.org/index-internals.html)

This documentation list covers up the internal handling of Perl inside the lower level, the C code, it also covers up, how you can add C code into your Perl modules (so called [XS](http://perldoc.perl.org/perlxs.html)). Normally you dont want to go here :).

* [Platform specific](http://perldoc.perl.org/index-platforms.html)

Here you get extra documentation about specific differences on specific platforms. As we dont cover those, you dont need to go here anyway. All documentations are definitly working as is on linux systems and there are no differences that are important here.

## use strict; use warnings;

Whatever you do, always be sure that you have **strict** and **warnings** in use. Normally, if you use object layer like Moo or Moose, you get those directly delivered in, so:

    use Moo;
	
automatically implies (and many more stuff):

    use strict;
    use warnings;

But you can only use this package for defining a class that can be instantiated, so if you write a simple Perl script, a .pl file, always start it with:

    use strict;
    use warnings;

Always.... really always.....

## Use CPAN

As Perl developer, you take heavy use of the Perl distributions on [CPAN](http://cpan.org/). CPAN covers up anything you need for development. Normally you find a distribution/module for any task you need todo. Some are good, some are bad, but the most important point is, you can easily help producing more CPAN distributions if you miss something. We will give some more information about how todo this later.

When you start to fulfill some specific requirements, you normally start by doing a search on [MetaCPAN](https://metacpan.org/), which is at the moment the state of the art CPAN search and documentation reading platform. Important here is: dont think like you need todo much. If you for example want to use an API of a specific webservice, and think like "oh it needs a MD5 hash, so i need a MD5 module", better start thinking like "Hey I wanna do something with Flickr, so i need a Flickr module", cause MANY stuff is directly covered up, and there is no need to recode something that is already there. If its not there, as said, make your own one and let others help you extend it, thats the beauty of Open Source :).

We on DuckDuckGo also have our own "CPAN" style server, we call it [DuckPAN](http://duckpan.org). It will be the upload station for your own contributions to DuckDuckGo, we have a wiki page about it here "[What is the DuckPAN?](https://github.com/duckduckgo/duckduckgo/wiki/DuckPAN)".

## The Community

On Perl development, and especially on Open Source teamwork, its very important to stay in contact with all other developers and the developers of the modules you use. Perl uses as most fast way IRC here, but you can reach all developers via the CPAN given email normally. Important is here to stay in contact with the community about general topics, dont try to trick around for hours, ask the community. If you are aware of IRC, you can just join the big community of Perl on irc.perl.org, where you also will find 

## DuckDuckGo and Perl

Of course, with all those documentations, you have lots of options and lots of possibilities. In the context of DuckDuckGo, we already have many suggestions (or required ways) to work with Perl for making useful contributions to us. These details are explained on the wiki page "[DuckDuckGo and Perl](https://github.com/duckduckgo/duckduckgo/wiki/DuckDuckGoPerl)".