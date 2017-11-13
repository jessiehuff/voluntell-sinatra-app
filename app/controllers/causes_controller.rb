class CausesController < ApplicationController

  # GET: /causes
  get "/causes" do
    if logged_in? 
      @causes = Cause.all 
      erb :"/causes/index.html"
    else 
      redirect '/login'
    end
  end

  # GET: /causes/new
  get "/causes/new" do
    if logged_in? 
      erb :"/causes/new.html"
    else 
      redirect '/login'
    end
  end

  # POST: /causes
  post "/causes" do
    if !params.value?("") 
      @cause = Cause.new(params)
      current_user.causes << @cause 
      redirect "/causes"
    else 
      redirect '/causes/new' 
    end
  end

  # GET: /causes/5
  get "/causes/:id" do
    erb :"/causes/show.html"
  end

  # GET: /causes/5/edit
  get "/causes/:id/edit" do
    erb :"/causes/edit.html"
  end

  # PATCH: /causes/5
  patch "/causes/:id" do
    redirect "/causes/:id"
  end

  # DELETE: /causes/5/delete
  delete "/causes/:id/delete" do
    redirect "/causes"
  end
end
