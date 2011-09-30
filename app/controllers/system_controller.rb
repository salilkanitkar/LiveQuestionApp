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

  def add_new_vote

    @thispost = Post.find(params[:post_id])
    @votedbefore = Vote.find_by_user_id_and_post_id(Integer(params[:user_id]), Integer(params[:post_id]))

    if @thispost.user_id == Integer(params[:user_id])

          flash[:error] = "You are not allowed to vote your own Post!"
          redirect_to  :controller => 'system', :action => 'index'

    elsif @votedbefore.nil? == true

      @thispost.numOfVotes = @thispost.numOfVotes + 1
      @thispost.save

      @thisvote = Vote.new
      @thisvote.user_id = params[:user_id]
      @thisvote.post_id = params[:post_id]
      @thisvote.save

      redirect_to  :controller => 'system', :action => 'index'

    elsif @votedbefore.nil? == false

      flash[:error] = "You are not allowed to vote the same Post more than once!"
      redirect_to  :controller => 'system', :action => 'index'

    end
  end

end

