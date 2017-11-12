require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
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
  end
end
