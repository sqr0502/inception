class UsersController < ApplicationController
  def new
    puts 'this was hit'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end
end
