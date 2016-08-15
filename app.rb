require 'sinatra'
require 'rimesync'
require 'json'

ts = TimeSync.new(baseurl = 'http://localhost:8000/v0')

ts.authenticate(username: 'ichait', password: 'passw', auth_type: 'password')

p ts.token_expiration_time # token expiration time

get '/' do
  erb :login, layout: false
end

get '/home' do
  erb :home
end

# get_activities
get '/activities' do
  erb :activities
end

# get_projects
get '/projects' do
  erb :projects
end

# get_times
get '/times' do
  erb :times
end

# get_users
get '/users' do
  erb :users, locals: { users: ts.get_users }
end

get '/users/:user' do
  data = []
  ts.get_users.each do |u|
    data.push(u) if u['username'] == params['user']
  end
  erb :get_values_form, locals: { values: data, user: params['user'] }
end

# Visualization: Project vs Hours Worked
get '/proj_vs_hours' do
  erb :proj_vs_hours
end

# Users vs Hours Worked on weekly/monthly basis
get '/users_vs_hours' do
  time_for_each_user = {}
  times = ts.get_times

  times.each do |time|
    name = time['user']

    # Convert all durations to seconds
    duration = time['duration']
    unless duration.is_a? Integer
      duration = ts.duration_to_seconds(duration)
    end

    # Group these times by project names
    if time_for_each_user.key? name
      time_for_each_user[name] += duration
    else
      time_for_each_user[name] = duration
    end
  end

  # Transform time_for_each_user into array of hashes required by d3
  rv = []
  time_for_each_user.each do |name, seconds|
    h = { 'user' => name, 'hours' => (seconds / 3600) }.to_json
    rv.push(h)
  end

  erb :users_vs_hours, locals: { values: rv }
end

# Activity variation for a user over a year
get '/activity_var' do
  erb :activity_var
end

# Activities vs Time Spent by org. on each project
get '/activity_vs_time' do
  erb :activity_vs_time
end
