require './config/environment'
require 'sinatra/base'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  configure do
    register Sinatra::ActiveRecordExtension
    use Rack::Flash
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:volunteer_id]
    end

    def current_user
      Volunteer.find(session[:volunteer_id])
    end

    def authenticate_user
      if !logged_in?
        redirect to '/login'
      end
  end
end
