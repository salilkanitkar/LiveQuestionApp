class SystemController < ApplicationController

  include SystemHelper

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

  def delete_user
    # Find all Votes made by this user, delete those votes and correspondingly decrement the votecount in posts
    @myvotes = Vote.find_all_by_user_id(params[:user_id])
    if @myvotes.nil? == false
      @myvotes.each do |myvote|
        thispost = Post.find(myvote.post_id)
        thispost.numOfVotes = thispost.numOfVotes - 1
        thispost.save
        myvote.destroy
      end
    end

    # Find all posts, by this user, delete all votes on all posts made by this user
    @myposts = Post.find_all_by_user_id(params[:user_id])
    if @myposts.nil? == false
      @myposts.each do |mypost|
        @myreplies = Post.find_all_by_parent(mypost.id)
        if @myreplies.nil? == false
          @myreplies.each do |myreply|
            delete_my_votes(myreply.id)
            myreply.destroy
          end
        end
        delete_my_votes(mypost.id)
        mypost.destroy
      end
    end

    @user = User.find(params[:user_id])
    @user.destroy

    redirect_to  :controller => 'system', :action => 'index'
  end
end

