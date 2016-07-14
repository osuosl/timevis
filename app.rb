require 'sinatra'

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
  erb :users
end

# Users vs Hours Worked on weekly/monthly basis
get '/users_vs_hours' do
  erb :users_vs_hours
end
