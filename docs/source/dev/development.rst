.. _development:

===============
Developer Guide
===============

Setup
-----

There are a few system requirements for installing a ruby-based application --
namely, ruby itself and gem, its package manager. Make sure that you have both
of these installed before you move forward. For Timevis we have used the Sinatra
Framework, so the next step should be install Sinatra with gem.

.. note::

  To check if your system already has a compatible version installed, run
  ``ruby --version``. For the project we have used ruby version ``2.2.1``.
  Try running gem list, and if it contains sinatra then you are all set.


If you are on a mac then you are good to go because mac already has ruby installed.
To install ruby manually, I would recommend using a ruby version manager like .. _`rvm`:  https://rvm.io/
For installing rvm follow .. _  `these instructions`: https://rvm.io/rvm/install
After you have rvm setup on your machine follow the following steps -

  $ rvm install 2.2.1
  $ ruby -v

This should say that you have ruby version 2.2.1 installed on your system.
If you see this then you are all set to install sinatra.

For installing sinatra -

  $ gem install sinatra

After installation of the system dependencies, install the project-specific
requirements using ``bundle`` in the root of the project repository::

  $ bundle install
  $ bower install

Congratulations, TimeVis is ready for development!


Running TimeVis
----------------

At this point, all of the requirements for TimeVis have been installed.

Run the server::

  ruby app.rb

.. note::
  You can also use ``shotgun app.rb`` to run the server.
  ``shotgun`` automatically restarts your server when some
  changes are made to any of the files.

TimeVis can now be accessed on ``http://localhost:4567``, or the port
specified in console output if appropriate.

Testing
-------

TimeVis comes with a single command to run the tests, linters, and test
coverage commands all at once.

  ruby tests.rb

You can run individual tests with -

  ruby tests.rb -n test_name

This will only run the test whose name you passed.

TimeVis uses rack-test for testing. See `its documentation`_ for more information
on how to write tests, or use the tests included in TimeVis as a guide. They
can be found in ``tests/``.

.. _`its documentation`: https://github.com/brynary/rack-test

Code standards
--------------

The TimeVis source code is linted using `RuboCop`_. This helps keep the code
base cleaner and more readable. For the most part, if an error occurs, it is
straightforward to fix it. For reference, a full list of messages is available
in the `JSHint source code`_.

To run the linter, just run::

  rubocop

This will pass the entire codebase through rubocop.

If you want to run the linter for an individual file, you can run::

  rubocop filename

.. _`RuboCop`: https://github.com/bbatsov/rubocop/


Travis CI
---------

Every time a commit is pushed to GitHub, Travis CI will automatically run the
test suite and marks the push as working or not. This is especially helpful
during code review.

Travis runs the test suite and the linter as described above.