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
#  started             :boolean
#

require 'tempfile'

class Job < ActiveRecord::Base
  include WatermarkHelper
  include ZipHelper
  
  has_many :images

  has_attached_file :file, :storage => :s3, :s3_credentials => S3_CREDENTIALS
  has_attached_file :output, :storage => :s3, :s3_credentials => S3_CREDENTIALS
  do_not_validate_attachment_file_type :file
  do_not_validate_attachment_file_type :output

  # after_commit :make_watermark_worker

  def watermark_it(fb_info)
    if not self.output.blank?
      return
    end
    
    # fb_info = get_facebook_info(self.info)[0]
    if self.file_content_type == 'image/jpeg'
      puts 'watermarking...'
      filename = "#{Rails.root}/tmp/" + self.file_file_name
      puts filename

      watermark(fb_info, self.file.expiring_url, filename)
      
    else
      # assuming zip for now
      images = process_images_from_job(self)
      watermarked_list = []
      
      tmp_dir = "#{Rails.root}" +  Dir.mktmpdir
      Dir.mkdir(tmp_dir) unless File.exists?(tmp_dir)

      puts images
      
      images.each do |img|
        info = img.original_file_name
        info = info.split('.')[0] # remove jpg
        info = info.gsub(/[ _]/, ' ')

        info = info + ' ' + self.info

        puts info
        
        fb_list = get_facebook_info(info)
        
        if fb_list.count == 1
          fb_info = fb_list[0]
          filename = tmp_dir + '/' + img.original_file_name
          puts "watermarking #{info}"
          watermark(fb_info, img.original.expiring_url, filename)
          watermarked_list.push(filename)
        end
        
      end

      
      p watermarked_list
      
      zip_path = "#{Rails.root}" + Tempfile.new(['tmp', '.zip']).path

      zip(zip_path, watermarked_list)

      filename = zip_path
    end
    
    file = File.open(filename)
    self.output = file
    # self.output.save
    self.save
  end

  def make_watermark_worker(fb_info)
    if self.started
      return
    end
    WatermarkFilesWorker.perform_async([self.id, fb_info])
  end

end
