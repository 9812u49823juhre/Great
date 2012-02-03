# Setting up a Perl development environment

## Getting the right base system

We at DuckDuckGo, only work with Linux (mostly Ubuntu and Debian) as base systems for our code, so we also only cover this in this documentation. It is essential that you have an Ubuntu or a Debian (it should have Perl 5.10 installed, which is on all stable version of those distributions), if you dont have those systems, you should think about installing a virtual machine on your system. Most easy is VMware Player which you can get from [here](http://www.vmware.com/products/player/). A Debian image you can get from [here](http://www.thoughtpolice.co.uk/vmware/#debian6.0). We require that you have some base knowledge of Linux and know how to handle a shell. We cant really give you hints how to obtain this knowledge, but you are welcome to visit us on our [Chat](http://webchat.freenode.net/?channels=duckduckgo) and we can talk about it :).

## Incase of trouble...

Please contact us and our community on our chat at http://webchat.freenode.net/?channels=duckduckgo if you have any problem with any of the following steps. The community likes to help people who want to contribute and do real work for DuckDuckGo, so no fear :). You can also contact us at open@duckduckgo.com via email.

## Installing required distribution packages

If you are using debian, all you need todo as root is this:

    apt-get install build-essential libgd2-xpm-dev libssl-dev git wget
	
This will bring on the most required things, even tho it could be that in different processes you need to install more distribution packages as root. But we will notice that at the specific points.

**WARNING:** This is the last time you need to use root, dont do anything else as root as installing distribution packages via apt-get

## Installing local::lib

As we explained in our [Overview of Perl](https://github.com/duckduckgo/duckduckgo/wiki/OverviewPerl), you need a proper way to install all your required modules, because you cant just copy them into your local directory. In Perl this is very easy with [local::lib](https://metacpan.org/module/local::lib). You could go through the documentation of "[The bootstrapping technique](https://metacpan.org/module/local::lib#The-bootstrapping-technique)", but in short you just need to execute the following commands:

    wget http://cpan.cpantesters.org/authors/id/A/AP/APEIRON/local-lib-1.008004.tar.gz
    tar xvzf local-lib-1.008004.tar.gz
    cd local-lib-1.008004
    perl Makefile.PL --bootstrap
    make test && make install
	
After you made those steps successful, so without any obvious huge error message :), you need to add a command to your shell startup script, which adds the proper ENV variables to your system, you can add it with this command if you dont know about your shell startup script (its suggesting you are using bash, which is default on all systems we suggested):

    echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >>~/.bashrc
	
Best is, if you now relogin to your account, and check if the ENV variables are proper set, you can do this with:

    set | grep [P]ERL5
	
If you see output here, then the ENV variables are set correctly, and you can go on with the next steps. You may now delete the local-lib-1.008004 directory, but do not delete the new perl5 directory in your home.

## Installing App::cpanminus

When you have installed local::lib proper, you are now able to install a more friendly package installer first. From now on, if you use any CPAN client, he will not try to install the distribution into the system Perl directory, it will install them into the newly generated perl5 directory in your home. At first we want to install [App::cpanminus](https://metacpan.org/module/App::cpanminus), which gives us the cpanm command to install distributions more smooth. You can do this via:

    cpan App::cpanminus

## Installing Dist::Zilla

The most required stuff for working on DuckDuckGo is [Dist::Zilla](https://metacpan.org/module/Dist::Zilla), which we use for managing our distributions. So the first thing you should install is this, which already brings on MANY other requirements for our other projects:

    cpanm Dist::Zilla
	
Especially see that its now "cpanm" instead of "cpan", cause we use App::cpanminus now. The output is much more userfriendly :-).

To find out more about Dist::Zilla you can go to the [Homepage](http://dzil.org/) of it. But we explain you more and more of it, through our documentations.

## Installing requirements of a Dist::Zilla distribution

All our Perl projects on GitHub, are Dist::Zilla distributions. You can see this cause of the dist.ini file, which is an essential part of a Dist::Zilla distribution. A Dist::Zilla distribution has specific Dist::Zilla Plugins which it requires. To get a list of those, you can use the dzil command which gets installed together with Dist::Zilla, you can pipe this output directly into cpanm:

    dzil authordeps --missing | cpanm
	
After this went successful, you can also install the requirements of the distribution itself with another easy command:

    dzil listdeps --missing | cpanm
	
## Making a Dist::Zilla profile for DuckDuckGo projects

...

