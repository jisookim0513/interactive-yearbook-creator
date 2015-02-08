# == Schema Information
#
# Table name: metadata
#
#  id         :integer          not null, primary key
#  facebook   :string(255)
#  linkedin   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Metadata < ActiveRecord::Base
end
