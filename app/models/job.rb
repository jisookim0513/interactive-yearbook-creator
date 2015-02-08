# == Schema Information
#
# Table name: jobs
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  file_file_name      :string(255)
#  file_content_type   :string(255)
#  file_file_size      :integer
#  file_updated_at     :datetime
#  info                :text
#  output_file_name    :string(255)
#  output_content_type :string(255)
#  output_file_size    :integer
#  output_updated_at   :datetime
#

require 'tempfile'

class Job < ActiveRecord::Base
  include WatermarkHelper
  
  has_many :images
  
  has_attached_file :file, :storage => :s3, :s3_credentials => S3_CREDENTIALS
  has_attached_file :output, :storage => :s3, :s3_credentials => S3_CREDENTIALS
  do_not_validate_attachment_file_type :file

  after_commit :make_watermark_worker
  
  def watermark_it
    puts 'watermarking...'
    filename = "#{Rails.root}/tmp/" + self.file_file_name
    puts filename
    
    watermark(self.info, self.file.expiring_url, filename)
    # TODO: check if helper returns true
    
    file = File.open(filename)
    self.output = file
    # self.output.save
    self.save
  end

  def make_watermark_worker
    WatermarkFilesWorker.perform_async(self.id)
  end
end
