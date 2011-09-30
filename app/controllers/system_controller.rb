class SystemController < ApplicationController

  def index
    @posts = Post.get_top_posts
  end

  def add_new_post
    @post = Post.new
    @post.question = params[:question]
    @post.user_id = params[:user_id]
    @post.save
    redirect_to  :controller => 'system', :action => 'index'
  end
end
