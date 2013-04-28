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

  
  @username_forLink = @auth.info.email.sub(/@gmail.com/, "")

  @timeZone_forLink = @result.data.items.last.timeZone

  @calender_id = @result.data.items.last.id

  @result2 = client.execute(:api_method => service.calendar_list.get,
                            :parameters => {'calendarId' => 'primary'})


  @result3 = client.execute(:api_method => service.events.list,
                          :parameters => {'calendarId' => 'primary'})

event = {
"end" =>
{
"date" => "2013-04-28"
},
"start" => 
{
"date" => "2013-04-28"
},
"summary" => "My Balls"
}

      @result4 = client.execute(:api_method => service.events.insert,
                              :parameters => {'calendarId' => 'primary'},
                              :body => JSON.dump(event),
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
