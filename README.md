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
* Graphs - [d3](https://github.com/d3/d3)
* Package manager for static files - [Bower](https://github.com/bower/bower)


### Documentation

More in-depth documentation can be found inside the docs/ folder. To build the docs, build them with sphinxdocs by running the following:

```
$ pip install -r requirements.txt
$ cd docs
[docs]$ make html
[docs]$ <browser> build/html/index.html
```