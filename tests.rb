require_relative 'app'
require 'test/unit'
require 'rack/test'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_login_endpoint
    get '/'
    assert last_response.body.include?('Please Sign In')
  end

  def test_home_endpoint
    get '/home'
    assert last_response.body.include?('View Details')
  end

  def test_activities_endpoint
    get '/activities'
    assert last_response.body.include?('Activities')
  end

  def test_projects_endpoint
    get '/projects'
    assert last_response.body.include?('Projects')
  end

  def test_times_endpoint
    get '/times'
    assert last_response.body.include?('Times')
  end

  def test_users_endpoint
    get '/users'
    assert last_response.body.include?('Users')
  end
end