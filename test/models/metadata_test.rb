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

require 'test_helper'

class MetadataTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
