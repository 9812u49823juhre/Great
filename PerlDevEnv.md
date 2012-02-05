# Setting up a Perl development environment

## Getting the right base system

Here at DuckDuckGo, we only work with Linux (mostly Ubuntu and Debian) as base systems for our code, so only Linux-based development will be covered here. We recommend you have Ubuntu or Debian (it should have Perl 5.10 installed, which is on all stable versions of those distributions); if you are not running either of these operating systems, we recommend you install a virtual machine on your system. Easiest to set up is VMware Player which you can get from [here](http://www.vmware.com/products/player/). You can get a Debian image from [here](http://www.thoughtpolice.co.uk/vmware/#debian6.0). We require that you have some basic knowledge of Linux and know how to handle a shell. We can't really give you hints as to how to obtain this knowledge, but if you have questions, you are welcome to visit us on our [Chat](http://webchat.freenode.net/?channels=duckduckgo) and we can talk about it :).

## In case of trouble...

Please contact us on our chatroom at http://webchat.freenode.net/?channels=duckduckgo if you run into problems with any of the following steps. The community likes to help people who want to contribute and do real work for DuckDuckGo, so don't be shy :). You can also contact us via email at open@duckduckgo.com .

## Installing required distribution packages

If you are using debian, all you need to do as root is this:

    apt-get install build-essential libgd2-xpm-dev libssl-dev git wget
	
This should download most of the Debian packages which you will need to set up a development envrionment, though you may need to install more distribution packages as root at later times. Any further need for package installation will be pointed out as and when it is necessary.

**WARNING:** This is the last time you will need to use root; don't do anything else as root except for installing distribution packages via apt-get

## Installing local::lib

As we explained in our [Overview of Perl](https://github.com/duckduckgo/duckduckgo/wiki/OverviewPerl), you need a proper way to install all your required modules, because you can't just copy them into your local directory. In Perl this is very easily done using [local::lib](https://metacpan.org/module/local::lib). You could go through the documentation of "[The bootstrapping technique](https://metacpan.org/module/local::lib#The-bootstrapping-technique)", but in short you just need to execute the following commands:

    wget http://cpan.cpantesters.org/authors/id/A/AP/APEIRON/local-lib-1.008004.tar.gz
    tar xvzf local-lib-1.008004.tar.gz
    cd local-lib-1.008004
    perl Makefile.PL --bootstrap
    make test && make install
	
After going through these steps successfully (i.e. without any obvious huge error message :)), you will need to add a command to your shell startup script, which adds the proper ENV variables to your system. You can add it with this command if you don't know about your shell startup script (assuming that you are using bash, which is default on all systems we suggested):

    echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >>~/.bashrc
	
At this point, it would be beneficial for you to relogin to your account, and check if the ENV variables are properly set; you can do this with:

    set | grep [P]ERL5
	
If you see an output here, then the ENV variables are set correctly, and you can go on with the next steps. You may now delete the local-lib-1.008004 directory, but do not delete the new perl5 directory in your home.

## Installing App::cpanminus

Once you have installed local::lib properly, you should be able to install a more friendly package installer. From now on, if you use any CPAN client, it will not try to install the distribution into the system Perl directory, it will install them into the newly generated perl5 directory in your home. First, we want to install [App::cpanminus](https://metacpan.org/module/App::cpanminus), which gives us the cpanm command to install distributions more smoothlu. You can do this via:

    cpan App::cpanminus

## Installing Dist::Zilla

The most important stuff for working on DuckDuckGo is [Dist::Zilla](https://metacpan.org/module/Dist::Zilla), which we use to manage our distributions. So the first thing you should install is this, which already brings on MANY other requirements for our other projects:

    cpanm Dist::Zilla
	
Note that it is now "cpanm" instead of "cpan", because we are now using App::cpanminus. The output is much more user-friendly :-).

To find out more about Dist::Zilla you can go to its [homepage](http://dzil.org/), but we'll explain its functioning further in later documentation.

## Installing requirements of a Dist::Zilla distribution

All of our Perl projects on GitHub, are Dist::Zilla distributions. This is indicated by the dist.ini file, which is an essential part of a Dist::Zilla distribution. A Dist::Zilla distribution has specific Dist::Zilla Plugins which it requires. To get a list of these, you can use the dzil command which gets installed together with Dist::Zilla (you can pipe this output directly into cpanm):

    dzil authordeps --missing | cpanm
	
After this works successfully, you can also install the requirements of the distribution itself with another easy command:

    dzil listdeps --missing | cpanm
	
## Making a Dist::Zilla profile for DuckDuckGo projects

...

