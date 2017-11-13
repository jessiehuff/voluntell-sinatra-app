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


  # GET: /causes/5
  get "/causes/:id" do
    erb :"/causes/show.html"
  end

end
