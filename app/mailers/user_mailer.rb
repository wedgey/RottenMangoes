class UserMailer < ApplicationMailer
  default from: 'notifications@rottenmangoes.com'

  def delete_email(user)
    @user = user
    @url = 'http://www.rottenmangoes.com'
    mail(to: @user.email, subject: 'Your account has been removed from RottenMangoes.com')
  end
end
