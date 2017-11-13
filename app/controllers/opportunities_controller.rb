class OpportunitiesController < ApplicationController

  # GET: /opportunities      this works
  get "/opportunities" do
    if logged_in?
      @opportunities = Opportunity.all
      erb :"/opportunities/index"
    else
      redirect '/login'
    end
  end

  get '/search' do   #trying this search feature
    @opportunities = Opportunity.all
    if params[:search]
      @opportunities = Opportunity.search(params[:search])
    else
      @opportunities = Opportunity.all
    end
    erb :'/opportunities/results'
  end

  # GET: /opportunities/new      this works
  get "/opportunities/new" do
    if logged_in?
      erb :"/opportunities/new"
    else
      redirect '/login'
    end
  end

  # POST: /opportunities     this works
  post "/opportunities" do
    if !params.value?("")
      @opportunity = Opportunity.new(params)
      current_user.opportunities << @opportunity
      redirect "/opportunities"
    else
      redirect '/opportunities/new'
    end
  end

  # GET: /opportunities/5  ok, this works
  get "/opportunities/:id" do
    if logged_in?
      @opportunity = Opportunity.find_by_id(params[:id])
      erb :"/opportunities/show"
    else
      redirect '/login'
    end
  end

  # GET: /opportunities/5/edit   this seems to work too
  get "/opportunities/:id/edit" do
    @opportunity = Opportunity.find_by_id(params[:id])
    if @opportunity && @opportunity.volunteer == current_user
      erb :"/opportunities/edit"
    else
      redirect '/login'
    end
  end

  # PATCH: /opportunities/5     *******fixed! :)
  post "/opportunities/:id" do
    if !params[:event].empty? && !params[:date].empty?
      @opportunity = Opportunity.find_by_id(params[:id])
      @opportunity.update(event: params[:event], date: params[:date], time: params[:time], description: params[:description], cause: params[:cause])
      redirect '/opportunities'
    else
      redirect "/opportunities/#{params[:id]}"
    end
  end

  # DELETE: /opportunities/5/delete        fixed!
  get "/opportunities/:id/delete" do
    if logged_in?
      @opportunity = Opportunity.find_by_id(params[:id])
      if @opportunity && (@opportunity.volunteer == current_user)
        @opportunity.delete
        redirect "/opportunities"
      else
        redirect "opportunities/#{@opportunity.id}"
      end
    else
      redirect '/login'
    end
  end
end
