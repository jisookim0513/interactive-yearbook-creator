class MakeMetadataFacebookText < ActiveRecord::Migration
  def change
    change_column(:metadata, :facebook, :text)
  end
end
