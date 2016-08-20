.. _usage:

===========
Usage Guide
===========


For using TimeVis you need to have a TimeSync account, contact someone from the OSL team
for getting an account created.

-----------------


Login into TimeVis
~~~~~~~~~~~~~~~~~~~

Once you have an account created in try logging into TimeVis with your username
and password that you must have recieved. TimeVis implements a password based authentication scheme.
As soon as you login a JWT token gets generated which has an expiration timer associated with it,
if the timer expires you will have to re login into the app.


Dashboard
~~~~~~~~~~

Welcome, what you see is the TimeVis Dashboard, you should see 4 chart options for visualizations
and 4 basic options including Activities, Projects, Times ,Users on the sidebar of the dashboard.


Charts
~~~~~~~

We currently have four type of visualzation in timevis, for detailed documentation of these charts
please refer to `Visualization Documentation for TimeVis`_.

_`Visualization Documentation for TimeVis`:


Activities
~~~~~~~~~~~

When you click on Activities tab in the sidebar you will get directed to the /activities endpoint.
Here you'll se a list of all activities that exist in TimeSync.

.. note::

  You will see only those activities for which you submitted a time entry, if you are a sitewide
  spectator only then you can see list of all activities that exist in TimeSync.


Projects
~~~~~~~~~~~

When you click on Projects tab in the sidebar you will get directed to the /projects endpoint.
Here you'll se a list of all projects that exist in TimeSync.

.. note::

  You will only see those projects for which you have atleast spectator permissions for.
  If you are a site wide spectator then you will get to see all projects irrespective of
  whether you have access to that project or not.


Times
~~~~~~~

When you click on Times tab in the sidebar you will get redirected to the /times endpoint.
Here you'll se a list of all submitted time entries in TimeSync.

.. note::

  If you don't have site wide spectator permissions then you'll see only times entries
  submitted by you.


Users
~~~~~~~

When you click on Users tab in the sidebar you will get redirected to the /users endpoint.
Here you'll se a list of all users that exist in TimeSync.

.. note::

  If you don't have site wide spectator permissions then you'll see only your name at
  /users endpoint.


activities/activity
~~~~~~~~~~~~~~~~~~~

Under the /activities tab you'll see a list of all the activities in TimeSync, now if
you click on any of the activities here you'll get directed to the endpoint `activities/slug`.
The `slug` here is the slug of that activity you selected.


projects/name
~~~~~~~~~~~~~~

Under the /projects tab you'll see a list of all the projects in TimeSync you have access for,
if you click on any of the projects here you'll get directed to the endpoint `projects/name`.
The `name` here is the name of the project you selected.


times/uuid
~~~~~~~~~~~~~~

Under the /times tab you'll see a list of all the submitted times in TimeSync you have access for,
if you click on any of the times here you'll get directed to the endpoint `times/uuid`.
The `uuid` here is the name of the time you selected.


users/username
~~~~~~~~~~~~~~

Under the /users tab you'll see a list of all the users in TimeSync, if you click on any of the
listed users here you'll get directed to the endpoint `users/username`. The `username` here is the
timesync username of the user you selected.