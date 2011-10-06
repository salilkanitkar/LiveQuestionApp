class SystemController < ApplicationController

  include SystemHelper

  def index
    @posts = Post.get_top_posts
    @from_system = 1
  end

  def see_all_questions
    @posts = Post.all(:conditions => {:parent => nil})
    @from_system = 1
  end

  def add_new_post
    if session[:id]
      @qsn = params[:question]
      @newpost = Post.new
      @newpost.question = @qsn
      @newpost.user_id = params[:user_id]
      @newpost.parent = nil
      @newpost.numofvotes = 0
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
      @newpost.numofvotes = 0
      @newpost.save
    else
      flash[:error] = "You must be sign in to reply to a question"
    end
    redirect_to(:back) # :controller => 'system', :action => 'index'
  end

  def add_new_vote
    @thispost = Post.find(params[:post_id])
    if session[:id]
      @votedbefore = Vote.find_by_user_id_and_post_id(Integer(params[:user_id]), Integer(params[:post_id]))

      if @thispost.user_id == Integer(params[:user_id])
        flash[:error] = "You are not allowed to vote your own Post!"
      elsif @votedbefore.nil? == true

        num = @thispost.numofvotes + 1
        @thispost.update_attribute(:numofvotes, num)

        @thisvote = Vote.new
        @thisvote.user_id = params[:user_id]
        @thisvote.post_id = params[:post_id]
        @thisvote.save
      elsif @votedbefore.nil? == false
        flash[:error] = "You are not allowed to vote the same Post more than once!"
      end
    else
      flash[:error] = "You must be sign in to reply to a question"
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
    if session[:id] and session[:isadmin]
      @myvotes = Vote.find_all_by_user_id(params[:user_id])
      if @myvotes.nil? == false
        @myvotes.each do |myvote|
          thispost = Post.find(myvote.post_id)
          thispost.numofvotes = thispost.numofvotes - 1
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
    else
      flash[:error] = "You must be signed as an Administrator to do this operation"
    end

    if params[:listing] == '1'
      redirect_to :controller => 'users', :action => 'index'
    else
      redirect_to :controller => 'system', :action => 'index'
    end
  end

  def grant_admin
    if session[:id] and session[:isadmin] == 1
      @user = User.find(params[:user_id])
      @user.update_attribute(:isadmin, 1)
    else
      flash[:error] = "You should be signed in as an Admin for this to happen"
    end
    redirect_to(:back)
  end

  def revoke_admin
    if session[:id] and session[:isadmin] == 1
      @user = User.find(params[:user_id])
      @user.update_attribute(:isadmin, 0)
    else
      flash[:error] = "You should be signed in as an Admin for this to happen"
    end
    redirect_to(:back)
  end

  def search_results
    @query = params[:system][:searchbox]
    results = []

    if !@query or @query == ""
      flash[:error] = "Search query cannot be empty"
      redirect_to :controller => 'system', :action => 'index'
    else
      keywords = @query.split.collect { |wrd| "#{wrd.downcase}"}

      if params[:system][:searchby] == '1'
        keywords.each do |key|
        Post.search(key).each { |p| results << p }
        end
      elsif params[:system][:searchby] =='2'

        if keywords.size > 1
          flash[:error] = "Please specify only one user name"
          redirect_to :controller => 'system', :action => 'index'
        else
          userlist = User.search(keywords[0])

          if !userlist.nil? and userlist.size > 0
            @username = '1'
            userlist.each do |usr|
              Post.find_all_by_user_id(usr.id).each {|p| results << p}
            end
          else
            @username = '0'
          end
        end
      end
      @posts = results.uniq
    end
  end
end
