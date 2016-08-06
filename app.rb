require 'sinatra'
require 'rimesync'
require_relative 'utils'

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
  erb :users_vs_hours
end

# Activity variation for a user over a year
get '/activity_var' do
  erb :activity_var
end

# Activities vs Time Spent by org. on each project
get '/activity_vs_time' do

  # TODO: Only display projects that the user has spectator permissions on
  projects = ts.get_projects
  activities = ts.get_activities
  per_project = {}

  projects.each do |project|
    # These calls can be optimized
    proj_times = ts.get_times({ "project" => [project["slugs"][0]] })
    time_for_each_act = {}

    proj_times.each do |time|
      duration = time["duration"]

      # Convert all durations to seconds
      if not duration.is_a? Integer
        duration = ts.duration_to_seconds(duration)
      end

      time["activities"].each do |activity|
        name = find_activity(activities, activity)

        # Group these times by activity name
        if time_for_each_act.key? name
          # BUG: This assumes that the time is equally divided amongst the activities
          time_for_each_act[name] += duration / time["activities"].length
        else
          time_for_each_act[name] = duration / time["activities"].length
        end

      end

    end

    per_project[project["name"]] = time_for_each_act
  end

  # Transform time_for_each_act into array of hashes required by d3
  rv = []
  per_project.each do |name, act_hash|
      project = { "Project" => name }

      act_hash.each do |act_name, seconds|
        project[act_name] = (seconds / 3600)
      end

      rv.push(project.to_json)
  end

  erb :activity_vs_time, locals: { values: rv }
end
