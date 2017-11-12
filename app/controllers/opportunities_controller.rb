class OpportunitiesController < ApplicationController

  # GET: /opportunities
  get "/opportunities" do
    if logged_in?
      @opportunities = Opportunity.all
      erb :"/opportunities/index"
    else
      redirect '/login'
    end
  end

  # GET: /opportunities/new
  get "/opportunities/new" do
    if logged_in?
      erb :"/opportunities/new"
    else
      redirect '/login'
    end
  end

  # POST: /opportunities
  post "/opportunities" do
    if !params.value?("")
      @opportunity = Opportunity.new(params)
      current_user.opportunities << @opportunity
      redirect "/opportunities"
    else
      redirect '/opportunities/new'
    end
  end

  # GET: /opportunities/5
  get "/opportunities/:id" do
    if logged_in?
      @opportunity = Opportunity.find_by_id(params[:id])
      erb :"/opportunities/show"
    else
      redirect '/login'
    end
  end

  # GET: /opportunities/5/edit
  get "/opportunities/:id/edit" do
    @opportunity = Opportunity.find_by_id(params[:id])
    if @opportunity && @opportunity.volunteer == current_user
      erb :"/opportunities/edit"
    else
      redirect '/login'
    end
  end

  # PATCH: /opportunities/5
  patch "/opportunities/:id" do
    if !params.value?("")
      @opportunity = Opportunity.find_by_id(params[:id])
      @opportunity.update(event: params[:event], date: params[:date], time: params[:time], description: params[:description])
      redirect '/opportunities'
    else
      redirect "/opportunities/#{params[:id]}"
    end
  end

  # DELETE: /opportunities/5/delete
  get "/opportunities/:id/delete" do
    @opportunity = Opportunity.find_by_id(params[:id])
    if @opportunity && @opportunity.volunteer == current_user
      @opportunity.delete
      redirect "/opportunities"
    else
      redirect '/opportunities'
    end
  end
end
