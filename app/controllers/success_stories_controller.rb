class SuccessStoriesController < ApplicationController

  # GET: /success_stories
  get "/success_stories" do
    erb :"/success_stories/index.html"
  end

  # GET: /success_stories/new
  get "/success_stories/new" do
    erb :"/success_stories/new.html"
  end

  # POST: /success_stories
  post "/success_stories" do
    redirect "/success_stories"
  end

  # GET: /success_stories/5
  get "/success_stories/:id" do
    erb :"/success_stories/show.html"
  end

  # GET: /success_stories/5/edit
  get "/success_stories/:id/edit" do
    erb :"/success_stories/edit.html"
  end

  # PATCH: /success_stories/5
  patch "/success_stories/:id" do
    redirect "/success_stories/:id"
  end

  # DELETE: /success_stories/5/delete
  delete "/success_stories/:id/delete" do
    redirect "/success_stories"
  end
end
