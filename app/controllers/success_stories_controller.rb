class SuccessStoriesController < ApplicationController

# GET: /success_stories         this works
get "/success_stories" do
  if logged_in?
    @success_stories = SuccessStory.all
    erb :"/success_stories/index"
  else
    redirect '/login'
  end
end

# GET: /success_stories/new      this works
get "/success_stories/new" do
  if logged_in?
    erb :"/success_stories/new"
  else
    redirect '/login'
  end
end

# POST: /success_stories         this works
post "/success_stories" do
  if !params.value?("")
    @success_story = SuccessStory.new(params)
    current_user.success_stories << @success_story
    redirect "/success_stories"
  else
    redirect '/success_stories/new'
  end
end

# GET: /success_stories/5        this works
get "/success_stories/:id" do
  if logged_in?
    @success_story = SuccessStory.find_by_id(params[:id])
    erb :"/success_stories/show"
  else
    redirect '/login'
  end
end

# GET: /success_stories/5/edit          works
get "/success_stories/:id/edit" do
  @success_story = SuccessStory.find_by_id(params[:id])
  if @success_story && @success_story.volunteer == current_user
    erb :"/success_stories/edit"
  else
    redirect '/login'
  end
end

# PATCH: /success_stories/5       got this to work! Woo!
post "/success_stories/:id" do
  if !params[:content].empty?
    @success_story = SuccessStory.find_by_id(params[:id])
    @success_story.update(author: params[:author], content: params[:content])
    redirect "/success_stories/#{params[:id]}"
  else
    redirect "/success_stories/#{params[:id]}/edit"
  end
end

# DELETE: /success_stories/5/delete
get "/success_stories/:id/delete" do
  if logged_in?
    @success_story = SuccessStory.find_by_id(params[:id])
    if @success_story && (@success_story.volunteer == current_user)
      @success_story.delete
      redirect "/success_stories"
    else
      redirect "/success_stories/#{@success_story.id}"
    end
  else
    redirect '/login'
  end
end
end
