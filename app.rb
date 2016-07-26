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
    data = []
    dummy_hash = {}
    time_for_each_act = {}
    times = ts.get_times.group_by { |d| d["project"] }  # group entries by project slugs

    times.each do |key, value|
      if key.length == 1  # test if slug array contains single entry
        dummy_hash.merge!(key=>value)
      else    # slug array contains multiple entries
        key.each do |k|
          if dummy_hash.key? k
            dummy_hash[k].push(value)
          else
            dummy_hash.merge!(k=>value)
          end
        end
      end
    end

    dummy_hash.each do |k,v|
      timing_docs = 0
      timing_code = 0
      timing_test = 0
      timing_rev = 0
      v.each do |val|
        if val["activities"] == ["docs"]
          timing_docs += val["duration"]
        elsif val["activities"] == ["coding"]
          timing_code += val["duration"]
        elsif val["activities"] == ["coding"]
          timing_test += val["duration"]
        else
          timing_rev += val["duration"]
      end
      time_for_each_act.merge!("Project"=>k
                                "Testing"=>timing_test,
                                "Coding"=>timing_code,
                                "Code_review"=>timing_rev,
                                "Documentation"=>timing_docs)
    end

    data.push(time_for_each_act)

  erb :activity_vs_time, locals: { values: data }
end
