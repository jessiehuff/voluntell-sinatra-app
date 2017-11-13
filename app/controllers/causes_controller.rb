class CausesController < ApplicationController

  # GET: /causes      *allow to view all causes
  get "/causes" do
    if logged_in?
      @causes = Cause.all
      erb :"/causes/index.html"
    else
      redirect '/login'
    end
  end


  # GET: /causes/5        *allow to view a specific cause
  get "/causes/:id" do
    if logged_in?
      @cause = Cause.find_by_id(params[:id])
      erb :"/causes/show.html"
    else
      redirect '/login'
    end
  end

end
