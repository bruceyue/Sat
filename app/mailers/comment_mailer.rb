class CommentMailer < ActionMailer::Base
  default from: "bruceyue001@gmail.com"
  #self.async = true

  def comment_email(article)
    @article = article
    mail(to: article.user.email, subject: article.subject)
  end

end
