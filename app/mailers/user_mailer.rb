class UserMailer < ActionMailer::Base
  default from: "team.trend.365@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #

  def signup_confirmation(user)
    @user = user
    @greeting = "Hi"

    mail to:  user.email, subject: "Sign Up Confirmation" do |format|
      format.html { render 'signup_confirmation'}
    end
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(:to => user.email,
       :subject => "Your password has been reset")
  end
end
