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

  get '/search' do
    @opportunities = Opportunity.all
    if params[:search]
      @opportunities = Opportunity.search(params[:search])
    else
      @opportunities = Opportunity.all
    end
    erb :'/opportunities/results'
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
    binding.pry
    if !params.value?("")
      @opportunity = Opportunity.new(event: params[:event], date: params[:date], time: params[:time], description: params[:description], cause: params[:cause])
      current_user.opportunities << @opportunity
      flash[:message] = "You've created a new opportunity!"
      redirect '/opportunities'
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
    if logged_in?
      if @opportunity && @opportunity.volunteer == current_user
        erb :"/opportunities/edit"
      else
        flash[:message] = "You can't edit this opportunity."
        redirect "opportunities/#{@opportunity.id}"
      end
    else
      redirect '/login'
    end
  end

  # PATCH: /opportunities/5
  post "/opportunities/:id" do
    if !params[:event].empty? && !params[:date].empty?
      @opportunity = Opportunity.find_by_id(params[:id])
      @opportunity.update(event: params[:event], date: params[:date], time: params[:time], description: params[:description], cause: params[:cause])
      flash[:message] = "You've successfully edited your opportunity."
      redirect '/opportunities'
    else
      flash[:message] = "You can't edit this opportunity."
      redirect "/opportunities/#{params[:id]}"
    end
  end

  # DELETE: /opportunities/5/delete
  get "/opportunities/:id/delete" do
    authenticate_user
    @opportunity = Opportunity.find_by_id(params[:id])
    if @opportunity && (@opportunity.volunteer == current_user)
      @opportunity.delete
      flash[:message] = "You've successfully deleted your opportunity."
      redirect "/opportunities"
    else
      flash[:message] = "You can't delete this opportunity."
      redirect "opportunities/#{@opportunity.id}"
    end
  end
end
