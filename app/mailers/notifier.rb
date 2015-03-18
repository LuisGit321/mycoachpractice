class Notifier < ActionMailer::Base
  default from: "no-reply@mycoachpractice.com"

  def student_signup_for_provider(student, provider)
    @student, @provider = student, provider
    mail to: @provider.email, subject: "Student confirmation request"
  end
end
