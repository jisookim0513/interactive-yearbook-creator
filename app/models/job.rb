# == Schema Information
#
# Table name: jobs
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Job < ActiveRecord::Base
  has_many :images

  has_attached_file :file, :storage => :s3, :s3_credentials => S3_CREDENTIALS
  do_not_validate_attachment_file_type :file
end
