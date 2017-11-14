class VolunteersController < ApplicationController
  #sign up
    get '/signup' do
      if logged_in?
        redirect '/opportunities'
      else
        erb :'/volunteers/signup'
      end
    end

    post '/signup' do
      if !params.value?("")
      @volunteer = Volunteer.create(params)
      if @volunteer
        session[:volunteer_id] = @volunteer.id
        redirect '/opportunities'
      end
      else
        redirect '/signup'
      end
    end

  #Log in
    get '/login' do
      if logged_in?
        redirect '/opportunities'
      else
        erb :'/volunteers/login'
      end
    end

    post '/login' do
      volunteer = Volunteer.find_by(username: params[:username])
      if volunteer && volunteer.authenticate(params[:password])
        session[:volunteer_id] = volunteer.id
        redirect '/opportunities'
      else
        redirect '/login'
      end
    end

  #Log Out

    get '/logout' do
      if !logged_in?
        redirect '/'
      else
        session.clear
        redirect '/login'
      end
    end


  # GET: /volunteers       works
  get "/volunteers" do
    @volunteers = Volunteer.all
    erb :"/volunteers/index"
  end

  # GET: /volunteers/5      works
  get "/volunteers/:id" do
    @volunteer = Volunteer.find(params[:id])
    erb :"/volunteers/show"
  end

  # GET: /volunteers/5/edit         works but need to do form**
  get "/volunteers/:id/edit" do
    @volunteer = Volunteer.find(params[:id])
    erb :"/volunteers/edit"
  end

  # PATCH: /volunteers/5
  post "/volunteers/:id" do
      if !params[:password].empty? && !params[:email].empty?
      @volunteer = Volunteer.find_by_id(params[:id])
      @volunteer.update(email: params[:email], password: params[:password])
      redirect '/opportunities'
    else
      redirect "/volunteers/:id"
    end
  end

end
