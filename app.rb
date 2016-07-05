require 'sinatra'
# require 'rimesync'
# require 'sinatra/flash'

enable :sessions
set :session_secret, 'secret'

get '/' do
  erb :login, :layout => false
end

get '/home' do
  if session['username'].nil?
    "401"
  else
    erb :home, :locals => {:username => session['username']}
  end
end

post '/home' do
  values = params
  session['username'] = params[:username]
  # "logged in as #{session[:username]}"
  erb :home, :locals => {:username => params[:username]}
  # puts params['username']
  # ts = TimeSync.new(baseurl = 'http://localhost:8000/v0')

  # ts.authenticate(username: params['username'], password: params['password'], auth_type: 'password')

  # if above == true
    # expire = ts.token_expiration_time
    # check for is_logged_in
    # erb :home
  # else:
    # "404"
    # erb: 404.erb
end


# get_activities
get '/activities' do
  if session['username'].nil?
    "401"
  else
    erb :activities, :locals => {:username => session['username']}
  end
end

# get_projects
get '/projects' do
  if session['username'].nil?
    "401"
  else
    erb :projects, :locals => {:username => session['username']}
  end
end

# get_times
get '/times' do
  if session['username'].nil?
    "401"
  else
    erb :times, :locals => {:username => session['username']}
  end
end

# get_users
get '/users' do
  if session['username'].nil?
    "401"
  else
    erb :users, :locals => {:username => session['username']}
  end
end

# Visualization: Project vs Hours Worked
get '/projVsHours' do
  if session['username'].nil?
    "401"
  else
    erb :projVsHours, :locals => {:username => session['username']}
  end
end

# Time Usage vs Life cycle of a project over months/years
get '/lifeCycle' do
  if session['username'].nil?
    "401"
  else
    erb :lifeCycle, :locals => {:username => session['username']}
  end
end

# Users vs Hours Worked on weekly/monthly basis
get '/usersVsHours' do
  if session['username'].nil?
    "401"
  else
    erb :usersVsHours, :locals => {:username => session['username']}
  end
end

# Activity variation for a user over a year
get '/activityVAr' do
  if session['username'].nil?
    "401"
  else
    erb :activityVAr, :locals => {:username => session['username']}
  end
end

# All Projects vs Team Size
get '/projVsTeam' do
  if session['username'].nil?
    "401"
  else
    erb :projVsTeam, :locals => {:username => session['username']}
  end
end

# Activities vs Time Spent by org. on each project
get '/activityVsTime' do
  if session['username'].nil?
    "401"
  else
    erb :activityVsTime, :locals => {:username => session['username']}
  end
end