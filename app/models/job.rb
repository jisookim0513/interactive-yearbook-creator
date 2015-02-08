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
end
