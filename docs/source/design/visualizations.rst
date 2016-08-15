.. _visualizations:

===============
Visualizations
===============

Currently, TimeVis implements 4 types of visualizations within it. The charts are designed using the d3
library.

The visualizations that are currently covered in TimeVis are -

- Projects Vs Hours Worked
- Users Vs Hours Worked
- Time spent by organization on different activities over all projects
- Time spent per activity for each project


Project Vs Hours Worked
------------------------


- X axis -­ All OSUOSL projects.
- Y axis ­- Time spent on each project (in Hours)


This visualization will allow us to identify which project takes up most of our time,
and also determine which projects are lagging behind and need our attention.

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


Users Vs Hours Worked
----------------------


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


Time spent by organization on different activities over all projects
--------------------------------------------------------------------


- X axis -­ All OSL projects.
- Y axis ­- Hours spent on all activities for each project (in Hours)


This visualization allow us to determine the time spent on various activities
for all the projects. This chart would help us to determine whether we are spending
sufficient time on all activities. For instance, this chart can indicate if time spent
on testing for any project is particulraly less and consequently we can take suitable
action and spend more time writing tests.

Working
~~~~~~~

We fetch all the time entries that exist in timesync using the call ``ts.get_times``
and then segregate these entries projectwise. Now, for each project we segregate the times
activity wise and further add times for each particulra activity.

.. note::
  For this visualization we need to be careful, as the graphs gets modified as soon
  as new activities get added into timesync.

endpoint
~~~~~~~~

The visualization is available at endpoint ``/activity_vs_time`` in the app.
So you just need to access the ``http://localhost:4567/activity_vs_time`` and you
should see the chart.

.. note::
  You'll only see data for all the projects if you are a site wide spectator,
  otherwise you'll see data for the projects you have at least spectator permissions
  for.

Time spent per activity for each project
----------------------------------------


This visualization constitues a pie chart, which is a graphical representation
of time spent on each activity for any project. With this visualtzaion we can easily deduce
for any project which particular activity is taking most of our time and which activity
is getting neglected. For instance there can be a scenario for a project where the share
of documentation is pretty low, so it indicates that we should spend more time writning
documentation for that project.

Working
~~~~~~~

We fetch all the time entries that exist in timesync using the call ``ts.get_times``
for any given project (provided by the user from the UI), now for the given project
user we add up all ``time['duration']`` of all the times for activity wise, consequently
we get times for each individual activity that was submitted for that project.


endpoint
~~~~~~~~

The visualization is available at endpoint ``/time_per_activity`` in the app.
So you just need to access the ``http://localhost:4567/time_per_activity`` and you
should see the chart.

.. note::
  You'll only see data for all the users if you are a site wide spectator,
  otherwise you'll see data for only yourself.
