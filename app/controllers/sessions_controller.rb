class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end


  def create
    #raise env["omniauth.auth"].to_yaml

    @user = User.create_with_omniauth(request.env["omniauth.auth"])
    session[:user_id] = @user.uid

    redirect_to "/users/#{@user.uid}", notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
