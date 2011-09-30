class SystemController < ApplicationController

  def index
    @posts = Post.get_top_posts
  end

  def create_new_post

  end

  def add_new_post
    @qsn = params[:question]
    @newpost = Post.new
    @newpost.question = @qsn
    @newpost.user_id = params[:user_id]
    @newpost.parent = nil
    @newpost.numOfVotes = 0
    @newpost.save
    redirect_to  :controller => 'system', :action => 'index'
  end

  def add_new_reply
    @qsn = params[:question]
    @newpost = Post.new
    @newpost.question = @qsn
    @newpost.user_id = params[:user_id]
    @newpost.parent = params[:post_id]
    @newpost.numOfVotes = 0
    @newpost.save
    redirect_to  :controller => 'system', :action => 'index'
  end

end
