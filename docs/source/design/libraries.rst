.. _libraries:

=========
Libraries
=========

Below are the most important libraries that TimeVis uses. For a complete list,
see the app's ``bower.json`` and Gemfile.

Sinatra
-------

It may not be as famous as Ruby on Rails but is a quick way to host minimal ruby
applications quickly. It is a DSL for quickly creating web applications in Ruby
with minimal effort.

For documentation on how to use
these, see the `Sinatra Documentation`_.

.. _Sinatra Documentation: http://www.sinatrarb.com/intro.html


Rimesync
--------

A ruby gem to interact with the TimeSync API. Rimesync plays a pivotal role
in the construction of timevis as all the data for the app is provided by
rimesync.

For documentation on how to use
rimesync, see the `Rimesync Documentation`_.

.. _Rimesync Documentation: http://github.com/osuosl/rimesync


Shotgun
-------

Shotgun is used for automatically reloading the server as soon as any changes
are made to the codebase. It is really convenient and saves the programmer
from the hassle of restarting the server again and again.

For documentation on how to use
these, see the `Shotgun Documentation`_.

.. _Shotgun Documentation: https://github.com/rtomayko/shotgun



rack-test
---------

Rack::Test is a small, simple testing API for Rack apps. It can be used on its own
or as a reusable starting point for Web frameworks and testing libraries to build on.

TimeSync uses rack-test for writing tests.

Read the documentation on how to write tets with rack-test:

* `rack_test documentation`_

.. _rack_test documentation: http://mochajs.org/

d3
---

D3.js is a JavaScript library for manipulating documents based on data.
You'll already have d3 if you run the command bower install, so no need
to worry about how to install it.


For more information, see the `d3 documentation`_.

.. _d3 documentation: https://d3js.org/

Bower
-----

Bower is basically a package manager for the web. Bower can manage components
that contain HTML, CSS, JavaScript, fonts or even image files. Bower doesn’t
concatenate or minify code or do anything else - it just installs the right
versions of the packages you need and their dependencies.

Bower is a command line utility, you can install it with npm.

    $ npm install -g bower

Sinatra::Flash
--------------

A lightweight utility for displaying important information or error messages
on a webapage.

For more information, see the `flash documentation`_.

.. _flash documentation: https://github.com/SFEley/sinatra-flash