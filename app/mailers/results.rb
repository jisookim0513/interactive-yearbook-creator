class Results < ActionMailer::Base
  default from: "Interactive Yearbook Creator"

  def test
    mail(:to => "krchtchk@gmail.com", :subject => "Another test...")
  end

  def job_mail(job_id)
    @job = Job.find(job_id)
    puts 'formatting job mail'

    mail(:to => @job.email, :subject => "Watermarked portrait(s) for #{@job.info}")
  end
  
end
