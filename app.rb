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
  # p ts.get_users
    time = {}
    time_for_each_user = []
    times = ts.get_times.group_by { |d| d["user"] }  # group entries by user

    times.each do |k,v|
      timing = 0
      v.each do |val|
        timing += val["duration"]   # till here we have one user and sum of all his times
      end
      time[k] = timing
      # time_for_each_user.merge!(k=>timing)
    end

    # ts.get_users do |user|
    #   if hash.key? "date"    # figure out how to make date as PK
    #     hash[user]=>time[user]
    #   else
    #     h2 = {"date"=>date}
    #     h2[user]=>time[user]
    #     time_for_each_proj.push(h2)
    #   end
    # end

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
