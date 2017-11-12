class VolunteersController < ApplicationController

  # GET: /volunteers
  get "/volunteers" do
    erb :"/volunteers/index.html"
  end

  # GET: /volunteers/new
  get "/volunteers/new" do
    erb :"/volunteers/new.html"
  end

  # POST: /volunteers
  post "/volunteers" do
    redirect "/volunteers"
  end

  # GET: /volunteers/5
  get "/volunteers/:id" do
    erb :"/volunteers/show.html"
  end

  # GET: /volunteers/5/edit
  get "/volunteers/:id/edit" do
    erb :"/volunteers/edit.html"
  end

  # PATCH: /volunteers/5
  patch "/volunteers/:id" do
    redirect "/volunteers/:id"
  end

  # DELETE: /volunteers/5/delete
  delete "/volunteers/:id/delete" do
    redirect "/volunteers"
  end
end
