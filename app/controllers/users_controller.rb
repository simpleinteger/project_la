class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

    def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :edit
    end
  end


def show
    @user = User.find_by(:uid => params[:id])

client = Google::APIClient.new
client.authorization.access_token = @user.token
service = client.discovered_api('calendar', 'v3')
      @result = client.execute(
          :api_method => service.calendar_list.list,
          :parameters => {},
          :headers => {'Content-Type' => 'application/json'})

            @username_forLink = @user.email.sub(/@gmail.com/, "")

            @timeZone_forLink = @result.data.items.last.timeZone

  end

end
