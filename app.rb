require 'sinatra'
require 'rimesync'
require 'sinatra/flash'

enable :sessions

get '/' do
  erb :login, layout: false
end

post '/' do
  ts = TimeSync.new(baseurl = 'http://localhost:8000/v0')
  token = ts.authenticate(username: params[:username],
                          password: params[:password],
                          auth_type: 'password')

  # If no error, proceed
  unless error_message(token)
    session['token'] = token['token']
    user = ts.get_users(params[:username])

    unless user
      return 'There was an error.', 500
    end

    session['user'] = user

    redirect '/home'
  else
    redirect '/'
  end
end

get '/home' do
  is_logged_in(:home)
end

get '/logout' do
  if session.key? 'user'
    session.delete('user')
  end

  if session.key? 'token'
    session.delete('token')
  end

  flash[:info] = "You've been logged out."
  redirect '/'
end

# get_activities
get '/activities' do
  if logged_in
    erb :activities, locals: { activities: @ts.get_activities }
  else
    not_logged_in
  end
end

get '/activities/:activity' do
  if logged_in
    erb :get_values_form, locals: { values: @ts.get_activities({ 'slug' => params['activity'] }),
                                    header: params['activity'] }
  else
    not_logged_in
  end
end

# get_projects
get '/projects' do
  if logged_in
    erb :projects, locals: { projects: @ts.get_projects }
  else
    not_logged_in
  end
end

get '/projects/:project' do
  if logged_in
    data = []
    users = []

    @ts.get_projects.each do |p|
      data.push(p) if p['name'] == params['project']
    end

    data.each do |d|
      users = d['users'].keys
    end
    users = users.join(',')
    erb :get_values_form, locals: { values: data, header: params['project'],
                                    users: users }
  else
    not_logged_in
  end
end

# get_times
get '/times' do
  if logged_in
    times = @ts.get_times.sort_by { |k| k['date_worked'] }
    erb :times, locals: { times: times }
  else
    not_logged_in
  end
end

get '/times/:time' do
  if logged_in
    erb :get_values_form, locals: { values: @ts.get_times({ 'uuid' => params['time'] }),
                                    header: params['time'] }
  else
    not_logged_in
  end
end

# get_users
get '/users' do
  # ts = TimeSync.new(baseurl='http://localhost:8000/v0',token=session['token'])
  if logged_in
    erb :users, locals: { users: @ts.get_users }
  else
    not_logged_in
  end
end

get '/users/:user' do
  if logged_in
    erb :get_values_form, locals: { values: @ts.get_users(params['user']),
                                    header: params['user'] }
  else
    not_logged_in
  end
end

# Visualization: Project vs Hours Worked
get '/proj_vs_hours' do
  is_logged_in(:proj_vs_hours)
end

# Users vs Hours Worked on weekly/monthly basis
get '/users_vs_hours' do
  is_logged_in(:users_vs_hours)
end

# Activity variation for a user over a year
get '/activity_var' do
  is_logged_in(:activity_var)
end

# Activities vs Time Spent by org. on each project
get '/activity_vs_time' do
  is_logged_in(:activity_vs_time)
end

not_found do
  status 404
end

def error_message(obj)
  # obj is empty, no error
  unless obj
    return false
  end

  # Make sure obj is hash
  obj = obj if obj.is_a? Hash else obj[0]

  if obj.key? 'error'
    flash[:error] = obj['error'] + ' - ' + obj['text']
    # There was an error
    return true
  elsif obj.key? 'rimesync error'
    flash[:error] = obj['rimesync error'].to_s
    # There was an error
    return true
  end
 # No error
 return false
end

def is_logged_in(obj)
  if session.key? 'user'
    erb obj
  else
    flash[:info] = 'You should be logged in to access this page.'
    redirect '/'
  end
end

def logged_in
  if session.key? 'user'
    @ts = TimeSync.new(baseurl='http://localhost:8000/v0',token=session['token'])
    return true
  else
    return false
  end
end

def not_logged_in
  flash[:info] = 'You should be logged in to access this page.'
  redirect '/'
end
