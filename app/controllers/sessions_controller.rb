class SessionsController < ApplicationController

  def new
    redirect_to '/auth/twitter'
  end


  def create

  #What data comes back from OmniAuth?     
  @auth = request.env["omniauth.auth"]
  #Use the token from the data to request a list of calendars
  @token = @auth["credentials"]["token"]
  client = Google::APIClient.new
  client.authorization.access_token = @token
  service = client.discovered_api('calendar', 'v3')
  @result = client.execute(
    :api_method => service.calendar_list.list,
    :parameters => {},
    :headers => {'Content-Type' => 'application/json'})
    
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
