require 'sinatra'

 get '/' do
   erb :login, :layout => false
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

 # Visualization: Project vs Hours Worked
 get '/projVsHours' do
   erb :projVsHours
 end

 # Time Usage vs Life cycle of a project over months/years
 get '/lifeCycle' do
   erb :lifeCycle
 end

 # Users vs Hours Worked on weekly/monthly basis
 get '/usersVsHours' do
   erb :usersVsHours
 end

 # Activity variation for a user over a year
 get '/activityVAr' do
   erb :activityVAr
 end

 # All Projects vs Team Size
 get '/projVsTeam' do
   erb :projVsTeam
 end

 # Activities vs Time Spent by org. on each project
 get '/activityVsTime' do
   erb :activityVsTime
 end