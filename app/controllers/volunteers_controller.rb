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
      if params.value?("")
        flash[:message] = "Please fill out all fields."
        redirect '/signup'
      end
      if !valid_email?
      flash[:message] = "Please enter a valid email."
        redirect '/signup'
      end
      if Volunteer.find_by(username: params[:username])
        flash[:message] = "Username is taken. Please try something else."
        redirect '/signup'
      end

      @volunteer = Volunteer.new(username: params[:username], email: params[:email], password: params[:password])
      if @volunteer.save
        session[:volunteer_id] = @volunteer.id
        flash[:message] = "You've successfully created an account!"
        redirect '/opportunities'
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
        if params.value?("")
          flash[:message] = "Please fill out all fields."
        else
          flash[:message] = "An error has occurred. Please check for typos."
        end
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


  # GET: /volunteers
  get "/volunteers" do
    authenticate_user
    @volunteers = Volunteer.all
    erb :"/volunteers/index"
  end

  # GET: /volunteers/5
  get "/volunteers/:slug" do
    authenticate_user
    @volunteer = Volunteer.find(params[:slug])
    erb :"/volunteers/show"
  end

  # GET: /volunteers/5/edit
  get "/volunteers/:slug/edit" do
    authenticate_user
    @volunteer = Volunteer.find(params[:slug])
    if logged_in?
      if @volunteer == current_user
        erb :"/volunteers/edit"
      else
        flash[:message] = "You can't edit this information."
        redirect "/opportunities"
      end
    else
      redirect '/login'
    end
  end


  # PATCH: /volunteers/5
  patch "/volunteers/:slug" do
    authenticate_user
      if !params[:password].empty? && !params[:email].empty?
      @volunteer = Volunteer.find_by_id(params[:slug])
      @volunteer.update(email: params[:email], password: params[:password])
      flash[:message] = "You've edited your profile."
      redirect '/opportunities'
    else
      redirect "/volunteers/:slug"
    end
  end

helpers do

  def valid_email?
    params[:email] =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end
end

end
