# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Image < ActiveRecord::Base

  has_attached_file :original
  has_attached_file :watermarked
  
end
