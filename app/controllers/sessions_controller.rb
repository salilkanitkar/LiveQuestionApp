class SessionsController < ApplicationController
  def new
    @title = "Sign In"
  end

  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid username/password combination."
      # redirect_to :action => "new"
      render 'new'
    else
      session[:id] = user.id
      session[:username] = user.username
      session[:password] = user.password
      session[:isadmin] = user.isadmin
      redirect_to :controller => :system, :action => "index"
    end
  end

  def destroy
    reset_session
    redirect_to:controller => :system, :action => "index"
  end

end
