require 'sinatra'

get '/' do
  erb :login, :layout => false
end

get '/home' do
  erb :home
end

get '/activities' do
  erb :activities
end

get '/projects' do
  erb :projects
end

get '/times' do
  erb :times
end

get '/users' do
  erb :users
end

get '/projVsHours' do
  # "Project vs Hours Worked"
  # erb :chart1, :layout => false
  erb :chart1
end

get '/lifeCycle' do
  "Time Usage vs Life cycle of a project over months/years."
end

get '/UsersVsHours' do
  "Users vs Hours Worked on weekly/monthly basis"
end

get '/ActivityVAr' do
  "Activity variation for a user over a year"
end

get '/ProjVsTeam' do
  'All Projects vs Team Size'
end

get '/activityVsTime' do
  'Activities vs Time Spent by org. on each project.'
end