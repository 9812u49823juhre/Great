### Overview 

[Repository](https://github.com/duckduckgo/zeroclickinfo-goodies)

For some 0-click we don't use any source but ourselves :). These range from [cheat sheets](http://duckduckgo.com/?q=html+chars) to [tools](http://duckduckgo.com/?q=pw) to [info](http://duckduckgo.com/?q=%23564). 

Cheat sheets can be an external HTML file we call via an iFrame, but the processing goodies are written in Perl since they get inserted into our core processing engine. Often there are existing Perl modules that will do things, which are ripe for Goodies. 

There are lots of Goodie ideas out there, including the following. Feel free to bring your own!

### Requests

 * em to px converter 
 * spelling corrector. We have spelling now but this would be more an explicit attempt to think of alternatives.
 * rhyming dictionary.
 * Improve "lorem ipsum" http://duckduckgo.com/?q=lorem+ipsum goodie so that it shows different text each time
 * Poker hands/probabilities
 * Javascript character codes
 * More [easter eggs](https://duckduckgo.com/?q=answer+to+the+ultimate+question+of+life+the+universe+and+everything)
 * A cheat sheet for all the goodies!
 * Joke/Sad/Funny -- random joke
 * Fun -- random fun thing (flash game?)
 * From [this thread](https://duck.co/topic/is-it-christmas-zero-click-info) "This would kind of be a fun one. A zero-click box sourced from isitchristmas.com would be hilarious. What say you all?"
 * From [this thread](https://duck.co/topic/zero-click-info-idea-reverse-dns) Reverse DNS
way?
 * It would be cool if typing something like "flash version" in DDG would return to me what flash player version I'm currently running. Similar to returning my IP address when "what is my ip" is typed.
 * capitalize x (including accent chars)
 * accents e -> accented chars with that base char

### Being Worked on
 * BEING WORKED ON Suicide hotline #s.
 * BEING WORKED ON Parsing crontab formats and explaining how they get called in a human readable manner :)
 * BEING WORKED ON It would be cool for designers to have a golden ratio calculator . So you type something like "golden ratio 1 : ?" and get 1.618033988749 or "golden ratio ? : 900" and get 556.2305898749.

### LIVE
 * [LIVE](http://duckduckgo.com/?q=binary+that) ([hunterlang](https://github.com/hunterlang)): binary ([code](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/binary/goodie.pl))
 * [LIVE](http://duckduckgo.com/?q=public+dns) ([warthurton](https://github.com/warthurton)): Public DNS servers ([code](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/public_dns))
 * [LIVE](http://duckduckgo.com/?q=guid) ([warthurton](https://github.com/warthurton)): GUID generator ([code](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/guid/goodie.pl))
 * [LIVE](http://duckduckgo.com/?q=throw+dice) ([warthurton](https://github.com/warthurton)): throw dice ([code](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/dice/goodie.pl)).
 * [LIVE](http://duckduckgo.com/?q=red+or+green+or+blue) ([warthurton](https://github.com/warthurton)): three way choice ([code](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/abc/goodie.pl)).
 * [LIVE](http://duckduckgo.com/?q=passphrase+4) (hungerlang): Passphrase ([code](https://github.com/duckduckgo/zeroclickinfo-goodies/tree/master/passphrase/)).


### Getting started

To get started in this category, check out the [Readme](https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/README.md) in the [Goodies repository](https://github.com/duckduckgo/zeroclickinfo-goodies). It explains how to organize your project, and then you can do a pull request and ultimately become a collaborator.

Feel free to edit this page and add to the above list if you have other source ideas or if you start working on one.