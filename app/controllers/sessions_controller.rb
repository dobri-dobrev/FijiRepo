class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  def new
  end
  def create
    user= User.find_by_name(params[:name])

    if user && user.authenticate(params[:password])
      session[:user_id]= user.id
      redirect_to links_url, :notice => "Logged in"
    else
      flash.now.alert= "Invalid user pass combo"
      render "new"
    end
  end
  def destroy
    session[:user_id] =nil
    redirect_to root_url
  end
end