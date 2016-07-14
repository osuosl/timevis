require 'sinatra'

get '/' do
  erb :login, layout: false
end

get '/home' do
  erb :home
end