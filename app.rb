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