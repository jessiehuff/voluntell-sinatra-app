class OpportunitiesController < ApplicationController
  # GET: /opportunities
  get "/opportunities" do
   authenticate_user
      @opportunities = Opportunity.all
      erb :"/opportunities/index"
  end

  get '/search' do
    authenticate_user
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
    authenticate_user
      erb :"/opportunities/new"
  end

  # POST: /opportunities
  post "/opportunities" do
    authenticate_user
       if !params.value?("")
         @opportunity = current_user.opportunities.build(event: params[:event], date: params[:date], time: params[:time], description: params[:description], cause: params[:cause])
         if @opportunity.save
           flash[:message] = "You've created a new opportunity!"
           redirect '/opportunities'
         end
       end
       redirect '/opportunities/new'
   end

  # GET: /opportunities/5
  get "/opportunities/:id" do
    authenticate_user
      @opportunity = Opportunity.find_by_id(params[:id])
      erb :"/opportunities/show"
  end

  # GET: /opportunities/5/edit
  get "/opportunities/:id/edit" do
    authenticate_user
    @opportunity = Opportunity.find_by_id(params[:id])
    if @opportunity && @opportunity.volunteer == current_user
      erb :"/opportunities/edit"
    else
      flash[:message] = "You can't edit this opportunity."
      redirect "opportunities/#{@opportunity.id}"
    end
  end

  # PATCH: /opportunities/5
  patch "/opportunities/:id" do
    authenticate_user
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
  delete "/opportunities/:id/delete" do
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
