require 'sinatra'
require 'rimesync'
require 'sinatra/flash'

enable :sessions

# p ts.token_expiration_time # token expiration time

get '/' do
  erb :login, layout: false
end

post '/' do
  ts = TimeSync.new(baseurl = 'http://localhost:8000/v0')
  token = ts.authenticate(username: params[:username],
                           password: params[:password],
                           auth_type: 'password')
  p params[:username]
  p params[:password]
  p token

  error_message(token)

  if token.key? 'rimesync error'
    # status = token['status']
    # p status
    flash[:error] = 'Error'
    redirect '/'
    # Else success, redirect to index page
  else
    session['token'] = token['token']

    user = ts.get_users(params[:username])

    if not user
      return 'There was an error.', 500
    end

    session['user'] = user

    redirect '/home'
  end
end

get '/home' do
  # protected!
  erb :home
end

# get_activities
get '/activities' do
  erb :activities, locals: { activities: ts.get_activities }
end

get '/activities/:activity' do
  erb :get_values_form, locals: { values: ts.get_activities({"slug"=> params['activity']}), header: params['activity'] }
end

# get_projects
get '/projects' do
  erb :projects, locals: { projects: ts.get_projects }
end

get '/projects/:project' do
  data = []
  users = []

  ts.get_projects.each do |p|
    data.push(p) if p['name'] == params['project']
  end

  data.each do |d|
    users = d['users'].keys
  end
  users = users.join(",")
  erb :get_values_form, locals: { values: data, header: params['project'], users: users }
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
  erb :get_values_form, locals: { values: ts.get_users(params['user']), header: params['user'] }
end

# Visualization: Project vs Hours Worked
get '/proj_vs_hours' do
  erb :proj_vs_hours
end

# Users vs Hours Worked on weekly/monthly basis
get '/users_vs_hours' do
  erb :users_vs_hours
end

# Activities vs Time Spent by org. on each project
get '/activity_vs_time' do
  erb :activity_vs_time
end

def error_message(array)
  if array.is_a? Hash
    if array.key? 'error'
      flash[:error] = 'Error: ' + array['error'].to_s + ' - ' + array['text'].to_s
      # There was an error
      return true
    elsif array.key? 'rimesync error'
      flash[:error] = 'Error: ' + array['rimesync error'].to_s + ' - ' +
                      array['text'].to_s
      # There was an error
      return true
    end
  elsif array.is_a? Array
    if array[0].include? 'error'
      flash[:error] = 'Error: ' + array[0]['error'].to_s + ' - ' +
                      array[0]['text'].to_s
      # There was an error
      return true
    elsif array.include? 'rimesync error'
      flash[:error] = 'Error: ' + array[0]['rimesync error'].to_s + ' - ' +
                      array[0]['text'].to_s
      # There was an error
      return true
    end
  end

  # No error
  false
end