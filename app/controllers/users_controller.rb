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
       sendEmail(data)
     end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :project_repo, :project_url, :ratings)
  end

  def sendEmail(data)

    #add the following objects to the string html data["full_name"] remember to treat them like variables
    #otherwise they won't appear on the string

    html = "<div style='background-color: #114B5F; width: 350px; padding: 3%;'><img style='display: block; margin: 0 auto;' src='http://trimagency.com/wp-content/uploads/2015/04/0.png'/>
            <table style='background-color:#FFFFFF;  text-align:left; margin-top: 2%;'><thead><br><tr><th style='text-align: center;
            font-size: 18px;' colspan='2'; margin-top: 5px;>Apprentice Submission</th></tr></thead><tbody>" +
            "<tr><th >Name:</th><td>#{data['full_name']}</td></tr>" +
             "<tr><th style=''>Email:</th><td>#{data['email']}</td></tr>" +
             "<tr><th style='text-align: center; font-size: 18px;' colspan='2'>Project Info</th></tr>" +
             "<tr><th style=''>Repo:</th><td><a href='#{data['project_repo']}'>#{data['project_repo']}</a></td></tr>" +
             "<tr><th style=''>URL:</th ><td><a href='#{data['project_url']}'>#{data['project_url']}</a></td></tr>" +
             "<br><tr ><th style='text-align: center; font-size: 18px;' colspan='2'; >Development Areas Rated</th></tr>"

    #create a loop that adds the ratings to the string html
    data["ratings"].each do |rating|
      html += "<tr ><th style='text-transform: uppercase;'>#{rating['name']}</th><td style='text-align: center; '>#{rating['rating']}</td></tr>"

    end

    html +=  "</tbody></table></div>"

    client = SendGrid::Client.new do |c|
      c.api_key = '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'
    end

    mail = SendGrid::Mail.new do |m|
       m.to = 'tim@trimagency.com'
       m.from = 'Automated'
       m.bcc = 'sqr0502@gmail.com'
       m.subject = 'Apprentice Submission'
       m.html = html
     end

     res = client.send(mail)
     p res.code
     p res.body
  end


end
