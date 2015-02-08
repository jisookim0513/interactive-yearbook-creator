class Results < ActionMailer::Base
  default from: "Interactive Yearbook Creator"

  def test
    mail(:to => "krchtchk@gmail.com", :subject => "Another test...")
  end

end
