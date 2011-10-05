class UsersController < ApplicationController

  include UsersHelper
  # GET /users
  # GET /users.json
  def index
    if session[:id]
      @users = User.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else
      flash[:error] = "You will need to Sign In to view this page."
      redirect_to :controller => 'system', :action => 'index'
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

    if session[:id]
      myposts = ""
      @from_list = params[:from_list]
      if params[:id]
        @user = User.find(params[:id])
      elsif session[:id]
        @user = User.find(session[:id])
      else
        flash[:error] = "You will need to Sign In to view this page."
        redirect_to :controller => 'system', :action => 'index'
      end

      if @user
        @numofposts = 0
        myposts = get_my_posts(@user)
        if myposts.nil? == false && myposts.instance_of?(Array)
          @numofposts = myposts.length
        end

        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
      else
        flash[:error] = "The user does not exist"
        redirect_to :controller => 'system', :action => 'index'
      end
    else
      flash[:error] = "You will need to Sign In to view this page."
      redirect_to :controller => 'system', :action => 'index'
    end

  end

  # GET /users/new
  # GET /users/new.json
  def new
    if params[:create_user] == '1' or session[:id]
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    else
      flash[:error] = "You will need to Sign In to view this page."
      redirect_to :controller => 'system', :action => 'index'
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

private
  def get_my_posts(user)
     myposts = Post.find_all_by_user_id(user.id)
     myposts
  end

end
