# Overview of Perl

## What is Perl?

Perl is a general purpose scripting language, which is often called "the glue of the internet". It is very flexible and powerful, and so it can be easily misused, which leads to a history full of misunderstandings - so please, forget all of the negative things you may have heard regarding Perl and start getting a feeling for the new, modern culture of Perl.

In order to really get a complete overview of the current Perl culture, we strongly suggest you read Onyx Neon's [free modern Perl book](http://www.onyxneon.com/books/modern_perl/). This will provide a concise overview of the most important things to know, directed mainly (but not only) at those who already know other programming languages and understand how software development functions.

To begin with, it is important to understand that even if Perl is a scripting language, many of the modules use compiled C code, which is why you can't just copy together some Perl modules (the .pm files) and assume that the result will work. The installation of a Perl distribution is a specific process, which is covered by the so-called "toolchain". Every language has such a toolchain to make it possible to install extensions of any kind. It is always very important not to break this toolchain, so that people can ensure their distributions get installed as they should. The advantage of Perl is that the language is so separate from the operating system, and that most actions can be performed in userspace without touching your local Perl installation in any way. All you need to do for this documentation and these tutorials can be done under a normal user account.

## Setup your development environment

It's very important that you first set up a little development environment to play around productively/safely with Perl. You can find the documentation here: "[How to install your Perl development environment](https://github.com/duckduckgo/duckduckgo/wiki/PerlDevEnv)". The Perl Foundation encourages to use modules with Perl, so as to avoid re-coding previously coded stuff, but doesn't pack the core Perl release full of modules, giving you the maximum level of choice as to which modules to install. This allows for many options to be chosen from to decide the path you take by coding with Perl. With the splitting of namespaces, it's even possible to combine several different coding styles in one huge codebase. You will see that when you are using it. Be aware that we only support and explain Perl development with Linux systems, preferedly Debian or Ubuntu, because those are the systems we use at DuckDuckGo.

## Learn Perl

When you are done setting up the development environment, you actually can start learning Perl itself, because without it you just limit yourself and get into awkward situations: upgrading a module on the system Perl could damage  your system distribution's integrity, and could lead to some serious damage to your system, so please be aware that whatever you do, do it as user account. Only the bare minimum of Perl can be really learned without this development environment. A relativey comprehensive overview of beginner tutorials for Perl can be found at "[Learn Perl](http://learn.perl.org)", but you can actually cover everything you need with the so-called "[Perl Programming Documentation](http://perldoc.perl.org/)". This collection of Perl base documentation covers a [huge list of specific tutorials and reference manuals](http://perldoc.perl.org/perl.html#Tutorials).

At the very least, should read the so-called "[perlintro](http://perldoc.perl.org/perlintro.html)". It provides a brief overview, which COULD be enough for you to start your way into Perl (or to refresh your knowledge). But if you are really serious about Perl, you shouldalso read more tutorials from the list above, or specific Perl reference manuals.

The references in a nutshell:

* [Language reference](http://perldoc.perl.org/index-language.html)

This documentation listing covers the language itself, the syntax, data structures, and all the things which let you understand how the interpreter works with the source code. Important to read is [Operators](http://perldoc.perl.org/perlop.html) and [Special Variables](http://perldoc.perl.org/perlvar.html).

* [Perl functions A-Z](http://perldoc.perl.org/index-functions.html)

This listing covers all functions that are available by default in Perl. Most of them you should already know from other languages, so it's probably a good idea to browse through them :). Dont feel sad if something you need is not covered , we will son discuss the power of CPAN which reveals much more options.

* [Pragmas](http://perldoc.perl.org/index-pragmas.html)

...

* [Utilities](http://perldoc.perl.org/index-utilities.html)

Here you can find an explanation of the tools and utilities which are delivered together with Perl. The only thing you need from here in most cases is the documentation for [prove](http://perldoc.perl.org/prove.html), which is used to run tests in Perl.

* [Internals and C language interface](http://perldoc.perl.org/index-internals.html)

This documentation list covers the internal handling of Perl at the lower level, the C code; it also covers how you can add C code into your Perl modules (so called [XS](http://perldoc.perl.org/perlxs.html)). There's no reason for you to consult this usually, but we thought we might include it just in case :).

* [Platform specific](http://perldoc.perl.org/index-platforms.html)

Here you can get extra documentation about specific differences on specific platforms. As we dont cover these, you don't need to go here anyway. All documentations are definitly correct as is for linux systems and there are no differences that are important here.

## use strict; use warnings;

Whatever you do, always be sure that you have **strict** and **warnings** in use. Normally, if you use an object layer like Moo or Moose, you get those directly delivered in, so:

    use Moo;
	
automatically implies (and a lot more stuff):
\
    use strict;
    use warnings;

But you can only use this package for defining a class that can be instantiated, so if you write a simple Perl script, a .pl file, always start it with:

    use strict;
    use warnings;

Always... Really, always...

## Use CPAN

As a Perl developer, you are likely to make significant use of the Perl distributions available on [CPAN](http://cpan.org/). CPAN covers anything you need for development. Normally you'll find a distribution/module for any task you need to do. Some are good, some are bad, but the most important point is, you can easily help produce more CPAN distributions if you can't find something. We will give some more information about how to do this later.

When you start a task which requires you to fulfill some specific requirements, you should normally start by doing a quick search on [MetaCPAN](https://metacpan.org/), which is at the moment the "state-of-the art" CPAN search and documentation reading platform. Important here is: dont think like you need todo much. If you for example want to use an API of a specific webservice, and think like "oh it needs a MD5 hash, so i need a MD5 module", better start thinking like "Hey I wanna do something with Flickr, so i need a Flickr module", cause MANY stuff is directly covered up, and there is no need to recode something that is already there. If its not there, as said, make your own one and let others help you extend it, thats the beauty of Open Source :).

We at DuckDuckGo also have our own "CPAN" style server: we call it [DuckPAN](http://duckpan.org). It will be the upload station for your contributions to DuckDuckGo - we have a wiki page about it here: "[What is the DuckPAN?](https://github.com/duckduckgo/duckduckgo/wiki/DuckPAN)".

## The Community

When developing stuff using Perl, and especially with Open Source teamwork, its very important to stay in contact with all other developers, and also the developers of the modules which you use. The quickest way to contact members of the Perl community is via IRC, but you can usually reach most developers via the email given on CPAN. It is paramanount to stay in contact with the community about general topics, don't waste hours of your day, ask the community. If you are aware of IRC, you can just join the big community of Perl on irc.perl.org, where you also will find...

## DuckDuckGo and Perl

Of course, with all this documentation, you have lots of options and lots of possibilities. In the context of DuckDuckGo, we already have many suggestions (or required ways) to work with Perl in order to make your contribution to us useful. These are detailed on the wiki page "[DuckDuckGo and Perl](https://github.com/duckduckgo/duckduckgo/wiki/DuckDuckGoPerl)".