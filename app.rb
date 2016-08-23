require 'sinatra'
require 'rimesync'
require_relative 'utils'
require 'json'
require 'sinatra/flash'
require 'sinatra/config_file'

config_file './config.yml'

enable :sessions

get '/' do
  erb :login, layout: false
end

post '/' do
  ts = TimeSync.new(baseurl = settings.url)
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
  if logged_in
    time_for_each_proj = {}
    times = @ts.get_times
    projects = @ts.get_projects

    times.each do |time|
      slug = time['project'][0]
      name = find_project(projects, slug)
      duration = time['duration']

      # Convert all durations to seconds
      unless duration.is_a? Integer
        duration = @ts.duration_to_seconds(duration)
      end

      # Group these times by project names
      if time_for_each_proj.key? name
        time_for_each_proj[name] += duration
      else
        time_for_each_proj[name] = duration
      end
    end

    # Transform time_for_each_proj into array of hashes required by d3
    rv = []
    time_for_each_proj.each do |name, seconds|
      h = { 'project' => name, 'hours' => (seconds / 3600) }.to_json
      rv.push(h)
    end

    erb :proj_vs_hours, locals: { values: rv }
  else
    not_logged_in
  end
end

# Users vs Hours Worked
get '/users_vs_hours' do
  if logged_in
    time_for_each_user = {}
    times = @ts.get_times

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
  else
    not_logged_in
  end
end

# Activity variation for a user over a year
get '/activity_var' do
  is_logged_in(:activity_var)
end

# Activities vs Time Spent by org. on each project
get '/activity_vs_time' do
  if logged_in
    projects = @ts.get_projects
    activities = @ts.get_activities
    per_project = {}

    projects.each do |project|
      # These calls can be optimized
      proj_times = @ts.get_times({ 'project' => [project['slugs'][0]] })
      time_for_each_act = {}

      proj_times.each do |time|
        duration = time['duration']

        # Convert all durations to seconds
        unless duration.is_a? Integer
          duration = @ts.duration_to_seconds(duration)
        end

        time['activities'].each do |activity|
          name = find_activity(activities, activity)

          # Group these times by activity name
          if time_for_each_act.key? name
            time_for_each_act[name] += duration
          else
            time_for_each_act[name] = duration
          end
        end
      end
      per_project[project['name']] = time_for_each_act
    end

    # Transform time_for_each_act into array of hashes required by d3
    rv = []
    per_project.each do |name, act_hash|
      # consider only those projects
      # for which atleast one time entry exists
      unless act_hash.empty?
        project = { 'Project' => name }
        unless act_hash.empty?
          act_hash.each do |act_name, seconds|
            project[act_name] = (seconds / 3600)
          end
        end

        @ts.get_activities.each do |act|
          unless project.key? act['name']
            project[act['name']] = 0
          end
        end

        rv.push(project.to_json)
      end
    end

    erb :activity_vs_time, locals: { values: rv }
  else
    not_logged_in
  end
end

get '/time_per_activity' do
  if logged_in
    rv = @ts.get_projects
    erb :time_per_act, locals: { values: rv }
  else
    not_logged_in
  end
end

# Time spent on each activity for all projects
post '/time_per_activity_post' do
  if logged_in
    proj_name = params[:pick_a_project]

    times = @ts.get_times({ 'project' =>
                           [find_project_slug(@ts.get_projects, proj_name)] })

    activities = @ts.get_activities

    time_for_each_act = {}

    times.each do |time|
      duration = time['duration']

      # Convert all durations to seconds
      unless duration.is_a? Integer
        duration = @ts.duration_to_seconds(duration)
      end

      time['activities'].each do |activity|
        name = find_activity(activities, activity)

        # Group these times by activity name
        if time_for_each_act.key? name
          time_for_each_act[name] += duration
        else
          time_for_each_act[name] = duration
        end

      end
    end

    if time_for_each_act.empty?
      error = 'No time entry exists for ' + proj_name + '. Please choose a different project.'
      erb :time_per_act_post, locals: { values: {}, project: '', error: error }
    else
      # Transform time_for_each_act into array of hashes required by d3
      rv = []
      time_for_each_act.each do |name, seconds|
        h = { 'activity' => name, 'hours' => (seconds / 3600) }.to_json
        rv.push(h)
      end
      erb :time_per_act_post, locals: { values: rv, project: proj_name, error: nil }
    end

  else
    not_logged_in
  end
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
  check_token_expiration_timer
  if session.key? 'user'
    erb obj
  else
    not_logged_in
  end
end

def logged_in
  check_token_expiration_timer
  if session.key? 'user'
    @ts = TimeSync.new(baseurl = settings.url, token = session['token'])
    return true
  else
    return false
  end
end

def not_logged_in
  flash[:info] = 'You should be logged in to access this page.'
  redirect '/'
end

def check_token_expiration_timer
  @ts = TimeSync.new(baseurl = settings.url, token = session['token'])
  expire = @ts.token_expiration_time

  if expire.is_a? Hash and (expire.key? 'error' or
                                expire.key? 'rimesync error')
    not_logged_in
  end

  if Time.now > expire
    redirect '/logout'
  end
end
