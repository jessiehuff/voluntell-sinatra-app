class SuccessStoriesController < ApplicationController
# GET: /success_stories
get "/success_stories" do
  authenticate_user
  @success_stories = SuccessStory.all
  erb :"/success_stories/index"
end

# GET: /success_stories/new
get "/success_stories/new" do
  authenticate_user
  erb :"/success_stories/new"
end

# POST: /success_stories
post "/success_stories" do
  authenticate_user
  if !params.value?("")
    @success_story = current_user.success_stories.build(author: params[:author],title: params[:title], content: params[:content])
    if @success_story.save
      flash[:message] = "Successfully created a story."
      redirect "/success_stories"
    end
  else
    redirect '/success_stories/new'
  end
end

# GET: /success_stories/5
get "/success_stories/:id" do
  authenticate_user
  @success_story = SuccessStory.find_by_id(params[:id])
  erb :"/success_stories/show"
end

# GET: /success_stories/5/edit
get "/success_stories/:id/edit" do
  authenticate_user
  @success_story = SuccessStory.find_by_id(params[:id])
  if logged_in?
    if @success_story && @success_story.volunteer == current_user
      erb :"/success_stories/edit"
    else
      flash[:message] = "You can't edit this story."
      redirect "/success_stories/#{@success_story.id}"
    end
  else
    redirect '/login'
  end
end

# PATCH: /success_stories/5
patch "/success_stories/:id" do
  authenticate_user
  if !params[:content].empty?
    @success_story = SuccessStory.find_by_id(params[:id])
    @success_story.update(author: params[:author],title: params[:title], content: params[:content])
    flash[:message] = "Successfully updated your story."
    redirect "/success_stories/#{params[:id]}"
  else
    flash[:message] = "You can't edit that story."
    redirect "/success_stories/#{params[:id]}/edit"
  end
end

# DELETE: /success_stories/5/delete
delete "/success_stories/:id/delete" do
  authenticate_user
    @success_story = SuccessStory.find_by_id(params[:id])
    if @success_story && (@success_story.volunteer == current_user)
      @success_story.delete
      flash[:message] = "Successfully deleted your story."
      redirect "/success_stories"
    else
      flash[:message] = "You can't delete this story."
      redirect "/success_stories/#{@success_story.id}"
    end
end
end
