### Overview

[Repository](https://github.com/duckduckgo/zeroclickinfo-fathead)

A lot of our zero-click info comes from essentially static data dumps, usually achieved through Web crawling (but could also originate from a data dump from the underlying provider). This category of 0-click involves getting the data (through crawling or from a dump) and then putting it in a form we can use. You could really do it in any language. Most of our stuff internally is in Perl, but people have already contributed in Python, node, Ruby and more.

We call it Fathead because it deals with the "fat head" of the query space and is essentially a keyword match operation, though with some fuzziness around the edges.

We should also note that this is a win-win for the data provider since we only show a small snippet and then link back to them at the very top of the results. However, it is often a good idea to OK it with the provider ahead of time. That is also useful because sometimes they will provide you with data dumps. Otherwise, make sure you crawl at a very slow rate and/or use open sources.

There are a lot of good data sources to integrate, and we maintain [a request list](https://github.com/duckduckgo/zeroclickinfo-fathead/blob/master/REQUESTS.md).

### Getting started

To get started in this category, check out the [Readme](https://github.com/duckduckgo/zeroclickinfo-fathead/blob/master/README.md) in the [Fathead Repository](https://github.com/duckduckgo/zeroclickinfo-fathead). It explains how to organize your project, and then you can do a pull request and ultimately become a collaborator.

