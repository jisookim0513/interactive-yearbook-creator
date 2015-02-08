class Results < ActionMailer::Base
  default from: "Interactive Yearbook Creator"

  def test
    mail(:to => "krchtchk@gmail.com", :subject => "Another test...")
  end

  def job_mail(job_id)
    @job = Job.find(job_id)
  end
  
end
