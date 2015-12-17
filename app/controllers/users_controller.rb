class UsersController < ApplicationController

  def getUsers
    render :json => User.all
  end
  
  def create
    @user = User.new(user_params)
     if @user.save
       render :json => @user
     end
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :project_repo, :project_url)
  end
end
