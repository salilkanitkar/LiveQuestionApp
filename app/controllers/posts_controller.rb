class PostsController < ApplicationController

  include PostsHelper

  # GET /posts
  # GET /posts.json
  def index
    redirect_to :controller => 'system', :action => 'index'
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if params[:from_reply_button] == '1' and !session[:id]
      flash[:error] = "You must Sign in to Post a reply"
      redirect_to :controller => 'system', :action => 'index'
    else
      @post = Post.find(params[:id])

      if @post
        if !@post.parent.nil?
          @post = Post.find(@post.parent)
        end

        if @post
          @posts = Post.get_replies(@post.id)

          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @post }
          end
        else
          flash[:error] = "The post you are trying to view does not exist."
          redirect_to :controller => 'system', :action => 'index'
        end
      else
        flash[:error] = "The post you are trying to view does not exist."
        redirect_to :controller => 'system', :action => 'index'
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    if session[:id]
      @post = Post.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @post }
      end
    else
      flash[:error] = "You must sign in to post a question"
      redirect_to :controller => 'system' , :action => 'index'
    end
  end

  # GET /posts/1/edit
  def edit
    redirect_to :controller => 'system', :action => 'index'
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    redirect_to :controller => 'system', :action => 'index'
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

    if session[:id] and session[:isadmin] == 1
      @myreplies = Post.find_all_by_parent(params[:id])
      if !@myreplies.nil?
        @myreplies.each do |myreply|
          delete_my_votes(myreply.id)
          myreply.destroy
        end
      end

      @post = Post.find(params[:id])
      if @post
        delete_my_votes(@post.id)
        @post.destroy

        respond_to do |format|
          format.html { redirect_to ('/askuery') }
          format.json { head :ok }
        end
      else
        flash[:error] = "The post is already deleted"
        redirect_to :controller => 'system', :action => 'index'
      end
    else
      flash[:error] = "You must be signed in as an Administrator to perform this action."
      redirect_to :controller => 'system', :action => 'index'
    end
  end
end
