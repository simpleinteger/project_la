class SystemsController < ApplicationController
  def test

    @user = User.find_by(:uid => params[:id])

  client = Google::APIClient.new
  client.authorization.access_token = @user.token
  service = client.discovered_api('calendar', 'v3')

  event = {
    "end" =>
    {
    "dateTime" => "2013-04-29T19:00:00Z"
    },
  "start" =>
    {
    "dateTime" => "2013-04-29T07:00:00Z"
    },
  }



  @result = client.execute(:api_method => service.events.insert,
                              :parameters => {'calendarId' => 'primary'},
                              :body => JSON.dump(event),
                              :headers => {'Content-Type' => 'application/json'})

  end
end
