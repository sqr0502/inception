class UsersController < ApplicationController
  require 'json'
  require 'mail'
  require 'sendgrid-ruby'

  def getUsers
    render :json => User.all
  end

  def create
    data = JSON.parse(request.body.read)
    @user = User.new(user_params)
     if @user.save
       render :json => @user
       data["ratings"].each do |rate|
         rating = Rating.new({:name => rate["name"], :rating => rate["rating"], :user_id => @user.id})
         rating.save
       end
       sendEmail
     end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :project_repo, :project_url, :ratings)
  end

  def sendEmail
    client = SendGrid::Client.new do |c|
      c.api_key = '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'
    end

    mail = SendGrid::Mail.new do |m|
       m.to = 'sqr0502@gmail.com'
       m.from = 'taco@cat.limo'
       m.subject = 'Hello world!'
       m.text = 'I heard you like pineapple.'
     end

     res = client.send(mail)
     p res.code
     p res.body
  end


end
