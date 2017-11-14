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
        flash[:message] = "Please fill out all of the fields."
        redirect '/signup'
      elsif !valid_email?(params)
        flash[:message] = "Please enter a valid email."
        redirect '/signup'
      elsif username_taken?(params)
        flash[:message] = "Username is taken. Please try something else."
        redirect '/signup'
      elsif !params.value?("")
        @volunteer = Volunteer.create(params)
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
      flash[:message] = "You've edited your profile."
      redirect '/opportunities'
    else
      redirect "/volunteers/:id"
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
