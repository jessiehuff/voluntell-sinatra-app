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
      if !valid_email?(params)
        flash[:message] = "Please enter a valid email."
        redirect '/signup'
      elsif username_taken?(params)
        flash[:message] = "Username is taken. Please try something else."
        redirect '/signup'
      elsif !params.value?("")
        @volunteer = Volunteer.create(username: params[:username], email: params[:email], password: params[:password])
        if @volunteer
          session[:volunteer_id] = @volunteer.id
          flash[:message] = "You've successfully created an account!"
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
        flash[:message] = "You've successfully logged in."
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
        flash[:message] = "You've successfully logged out."
        session.clear
        redirect '/login'
      end
    end


  # GET: /volunteers
  get "/volunteers" do
    @volunteers = Volunteer.all
    erb :"/volunteers/index"
  end

  # GET: /volunteers/5
  get "/volunteers/:slug" do
    @volunteer = Volunteer.find(params[:slug])
    erb :"/volunteers/show"
  end

  # GET: /volunteers/5/edit
  get "/volunteers/:slug/edit" do
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
  post "/volunteers/:slug" do
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
  def username_taken?(params)
    Volunteer.all.detect {|volunteer| params[:username] == volunteer.username}
  end

  def valid_email?(params)
    params[:email] =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end
end

end
