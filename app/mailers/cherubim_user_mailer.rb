class CherubimUserMailer < ApplicationMailer
  def new_email(email)
    mail(to: email, subject: 'Confirm your email account')
  end
end
