## Timesync-Visualizations

A ruby application for Timesync Visualizations and basic implementation of the rimesync gem.

### Build Instructions
 
 ```
 $ git clone https://github.com/osuosl/timevis
 $ cd timevis
 $ bundle install
 $ bower install
 ```
 
 
 ### Running the app
 
 ```
 $ ruby app.rb
 ```
 
 Or reload development server - 
 
 ```
 $ shotgun app.rb
 ```


### Libraries Used

* Framework- [sinatra](https://github.com/sinatra/sinatra)
* Bootstrap Theme - [sb-admin-2](https://github.com/BlackrockDigital/startbootstrap-sb-admin-2)
* Graphs - [nvd3](https://github.com/novus/nvd3/)
* Package manager for static files - [Bower](https://github.com/bower/bower)


### Visualizations

#### 1. Project vs Hours Worked

* **X axis** - All OSL Projects.
* **Y axis** - Time spent on each project (in Hours).

[Visualization Used](https://nvd3-community.github.io/nvd3/examples/discreteBarChart.html)

#### 2. Activities vs Time Spent by the organization

* **X axis** - All OSL projects.
* **Y axis** - Time spent on all activities for each project (in Hours).

[Visualization Used](https://nvd3-community.github.io/nvd3/examples/stackedAreaChart.html)

#### 3. Users vs Hours Worked on weekly/monthly basis

* **X axis** - Days or Months ( eg. Mon,Tue.....Sun or Jan,Feb ....Dec ).
* **Y axis** - Time spent by each user (in Hours).

[Visualization Used](https://nvd3-community.github.io/nvd3/examples/cumulativeLineChart.html)

#### 4. Time Usage vs Life cycle of a project over years/months

* **X axis** - Months or Years (eg. Jan, Feb.. or 2015, 2016...).
* **Y axis** - Time spent (in Hours).

[Visualization Used](https://nvd3-community.github.io/nvd3/examples/cumulativeLineChart.html)

#### 5. Activity variation for a user over a year

* **X axis** - Months (Jan, Feb, ........Dec).
* **Y axis** - Number of times submitted.

[Visualization Used](https://nvd3-community.github.io/nvd3/examples/multiBarChart.html)

#### 6. All Projects vs Team Size

* **X axis** - All OSL Projects.
* **Y axis** - Team Size (Members + Spectators + Managers).

[Visualization Used](https://nvd3-community.github.io/nvd3/examples/multiBarChart.html)
