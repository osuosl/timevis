.. _visualizations:

===============
Visualizations
===============

Currently, TimeVis implements 4 types of visualizations within it. The charts are designed using the d3
library.

The visualizations that are currently covered in TimeVis are -

- `Projects Vs Hours Worked`_
- `Users Vs Hours Worked`_
- `Time spent by organization on different activities over all projects`_
- `Time spent per activity for each project`_


.. _`Project Vs Hours Worked`
----------------------------


- X axis -­ All OSUOSL projects.
- Y axis ­- Time spent on each project (in Hours)


This visualization will allow us to identify which project takes up most of our time,
and also determine which projects are lagging behind and need our attention.

A live demo of the visualization is available here_.

.. note::
  The demo graph shown in the example uses dummy data set.


Working
~~~~~~~

We fetch all the time entries that exist in timesync for all projects using the call
``ts.get_times`` and then segregate the entries projectwise, now for each particular
project we add all ``time['duration']`` of all the times for
that project, consequently the time obtained is the total time spent on that particular
project.


endpoint
~~~~~~~~

The visualization is available at endpoint ``/proj_vs_hours`` in the app.
So you just need to access the ``http://localhost:4567/proj_vs_hours`` and you
should see the chart.

.. note::
  You'll only see data for those projects for which you have atleast
  spectator permissions for.

.. _here -  ­http://bl.ocks.org/iCHAIT/10986ac3f8172a6344e5


.. _`Users Vs Hours Worked`
----------------------------


- X axis ­ Days or Months ( eg. Mon,Tue.....Sun or Jan,Feb ....Dec )
- Y axis ­ Time spent by each user (in Hours)


This visualization will provide us with some performance measurement metric, with this
we can easily figure out which user is contributing the most and who needs to buck up.

Working
~~~~~~~

We fetch all the time entries that exist in timesync using the call ``ts.get_times``
and then segregate these entries userwise, now for each particular user we add
all ``time['duration']`` of all the times for that user, consequently the time obtained
is the total time spent by that particular user.


endpoint
~~~~~~~~

The visualization is available at endpoint ``/users_vs_hours`` in the app.
So you just need to access the ``http://localhost:4567/users_vs_hours`` and you
should see the chart.

.. note::
  You'll only see data for all the users if you are a site wide spectator,
  otherwise you'll see data for only yourself.
