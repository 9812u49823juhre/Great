# What is the DuckPAN?

## General purpose

The [DuckPAN](http://duckpan.org) is our central release registry for all our opensource code distributions. The main purpose is to open a release based contribution concept which allows the developer to NOT leave his common workflow to generate the contributions for DuckDuckGo.

## Uploading Perl distributions

For uploading Perl modules to DuckPAN, we added a PAUSE like upload point, which you can use with the [Community Platform](https://dukgo.com/) credentials. We provide a [Dist::Zilla](https://metacpan.org/module/Dist::Zilla) module as [Dist::Zilla::Plugin::UploadToDuckPAN](https://metacpan.org/module/Dist::Zilla::Plugin::UploadToDuckPAN), which makes it trivial to upload a Perl distribution to our DuckPAN.

## Uploading Python distributions

TODO - we are working on it

## Uploading NodeJS distributions

TODO - we are working on it

## Uploading Ruby distributions

TODO - we are working on it

## Uploading JavaScript

For uploading the so called "spice" for DuckDuckGo, you will need to include some JavaScript which is the main work of your contribution. Those contributions are still required to be given as Perl distribution, but this process is explained in the documentation for [Zero-click Info Spice](https://github.com/duckduckgo/zeroclickinfo-spice/wiki).

