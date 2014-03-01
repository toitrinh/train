class NewsletterMailer < ActionMailer::Base
  default from: "romanotrinhtoi@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.newsletter_mailer.weekly.subject
  #
  def weekly(email, comment, post)
    
    @comment = comment
    @post = post

    mail to: email, subject: "Your post have new comment !"
  end
end
