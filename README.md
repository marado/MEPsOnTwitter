# MEPsOnTwitter
A list of Members of the European Parliament on Twitter, on Javascript format

[European-Parliament-Open-Data](https://github.com/eliflab/European-Parliament-Open-Data)
is a very nice project that publishes a (maintained) list of European MEPs,
including the country they represent and their twitter accounts, on CSV. This
valuable data can be used in several ways, one of which is to build some
software (a website, for eg.) around it. For that purpose, MEPsOnTwitter
publishes a version of that same data in an includeable Javascript file,
allowing your project to automaticly generate a list of MEPs, allow you to
tweet to them, or anything else you can think of.

This repository contains the following relevant files:
* js-generator.sh - a script that fetches the CSV and transforms it into a JavaScript file
* MEPs-on-Twitter.js - the output of js-generator.sh

## Usage

Use this in any way you want. If you use this somewhere, feel free to let me
know!

This is used (at least) in: 

* TTIPTuesday - http://marado.github.io/TTIPTuesday
* Central de Dados - https://github.com/centraldedados/PARLAMENTOEU-deputados-Twitter
* CETACheckTwitter - http://marado.github.io/CETACheckTwitter
