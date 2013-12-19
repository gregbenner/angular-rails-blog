class PostsController < ApplicationController
  respond_to :json

  def index
    # gather all post data
    posts = Post.all

    # Respond to request with post data in json format
    respond_with(posts) do |format|
      format.json { render :json => posts.as_json }
    end
  end

  def create
    new_post = Post.new
    new_post.title = params[:new_post][:title][0..250] # get only 250 characters
    new_post.contents = params[:new_post][:contents]

    if new_post.valid? # checks against our model post.rb validation checks
      new_post.save!
    else
      render "public/422", :status => 422
      return
    end

    # respond with the new post in json format
    respond_with(new_post) do |format|
      format.json {render :json => new_post.as_json }
    end

  end
end
