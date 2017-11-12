class OpportunitiesController < ApplicationController

  # GET: /opportunities
  get "/opportunities" do
    erb :"/opportunities/index.html"
  end

  # GET: /opportunities/new
  get "/opportunities/new" do
    erb :"/opportunities/new.html"
  end

  # POST: /opportunities
  post "/opportunities" do
    redirect "/opportunities"
  end

  # GET: /opportunities/5
  get "/opportunities/:id" do
    erb :"/opportunities/show.html"
  end

  # GET: /opportunities/5/edit
  get "/opportunities/:id/edit" do
    erb :"/opportunities/edit.html"
  end

  # PATCH: /opportunities/5
  patch "/opportunities/:id" do
    redirect "/opportunities/:id"
  end

  # DELETE: /opportunities/5/delete
  delete "/opportunities/:id/delete" do
    redirect "/opportunities"
  end
end
