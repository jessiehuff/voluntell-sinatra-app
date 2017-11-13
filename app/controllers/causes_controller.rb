class CausesController < ApplicationController

  # GET: /causes
  get "/causes" do
    erb :"/causes/index.html"
  end

  # GET: /causes/new
  get "/causes/new" do
    erb :"/causes/new.html"
  end

  # POST: /causes
  post "/causes" do
    redirect "/causes"
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
