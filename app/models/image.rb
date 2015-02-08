# == Schema Information
#
# Table name: images
#
#  id                       :integer          not null, primary key
#  status                   :integer
#  created_at               :datetime
#  updated_at               :datetime
#  original_file_name       :string(255)
#  original_content_type    :string(255)
#  original_file_size       :integer
#  original_updated_at      :datetime
#  watermarked_file_name    :string(255)
#  watermarked_content_type :string(255)
#  watermarked_file_size    :integer
#  watermarked_updated_at   :datetime
#  job_id                   :integer
#  metadata_id              :integer
#

class Image < ActiveRecord::Base

  has_attached_file :original
  has_attached_file :watermarked
  has_one :metadata

  belongs_to :job
end
