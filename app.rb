require 'sinatra'
require 'rimesync'

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
  times = ts.get_times.sort_by { |k| k["date_worked"] }
  erb :times, locals: { times: times }
end

get '/times/:time' do
  erb :get_values_form, locals: { values: ts.get_times({"uuid"=> params['time']}), header: params['time'] }
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
  erb :get_values_form, locals: { values: data, header: params['user'] }
end

# Visualization: Project vs Hours Worked
get '/proj_vs_hours' do
  erb :proj_vs_hours
end

# Users vs Hours Worked on weekly/monthly basis
get '/users_vs_hours' do
  erb :users_vs_hours
end

# Activity variation for a user over a year
get '/activity_var' do
  erb :activity_var
end

# Activities vs Time Spent by org. on each project
get '/activity_vs_time' do
  erb :activity_vs_time
end
