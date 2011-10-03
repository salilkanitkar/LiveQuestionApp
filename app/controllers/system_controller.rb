class SystemController < ApplicationController

  include SystemHelper

  def index
    @posts = Post.get_top_posts
    @from_system = 1
  end

  def add_new_post
    if session[:id]
      @qsn = params[:question]
      @newpost = Post.new
      @newpost.question = @qsn
      @newpost.user_id = params[:user_id]
      @newpost.parent = nil
      @newpost.numOfVotes = 0
      @newpost.save
    else
      flash[:error] = "You must be sign in to post a new question"
    end
    redirect_to :controller => 'system', :action => 'index'
  end

  def add_new_reply

    if session[:id]
      @qsn = params[:question]
      @newpost = Post.new
      @newpost.question = @qsn
      @newpost.user_id = params[:user_id]
      @newpost.parent = params[:post_id]
      @newpost.numOfVotes = 0
      @newpost.save
    else
      flash[:error] = "You must be sign in to reply to a question"
    end
    redirect_to(:back) # :controller => 'system', :action => 'index'
  end

  def add_new_vote

    if session[:id]
      @thispost = Post.find(params[:post_id])
      @votedbefore = Vote.find_by_user_id_and_post_id(Integer(params[:user_id]), Integer(params[:post_id]))

      if @thispost.user_id == Integer(params[:user_id])
        flash[:error] = "You are not allowed to vote your own Post!"
      elsif @votedbefore.nil? == true

        @thispost.numOfVotes = @thispost.numOfVotes + 1
        @thispost.save

        @thisvote = Vote.new
        @thisvote.user_id = params[:user_id]
        @thisvote.post_id = params[:post_id]
        @thisvote.save
      elsif @votedbefore.nil? == false
        flash[:error] = "You are not allowed to vote the same Post more than once!"
      end
    else
      flash[:error] = "You must be signed in to reply to a question"
    end

    if params[:caller] == 'system'
      redirect_to :controller => 'system', :action => 'index'
    else
      if @thispost.parent.nil?
        redirect_to :controller => 'posts', :action => 'show', :id => @thispost.id
      else
        redirect_to :controller => 'posts', :action => 'show', :id => @thispost.parent
      end
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

    redirect_to :controller => 'system', :action => 'index'
  end

  def grant_isadmin
    myuser = User.find(Integer(params[:user_id]))
    # flash[:error] = "The isadmin is :"+String(myuser.isadmin)+":"
    if myuser.isadmin == 1
      flash[:error] = "This user is already an Admin"
      redirect_to :controller => 'system', :action => 'index'
    else
      # myuser.isadmin = 1
      myuser.update_attribute(:isadmin, 1)
      redirect_to :controller => 'system', :action => 'index'
    end
  end

  def revoke_isadmin
    myuser = User.find(params[:user_id])
    if myuser.isadmin == 0
      flash[:error] = "This user is not an Admin"
      redirect_to :controller => 'system', :action => 'index'
    else
      # myuser.isadmin = 0
      myuser.update_attribute(:isadmin, 0)
      redirect_to :controller => 'system', :action => 'index'
    end
  end
end

