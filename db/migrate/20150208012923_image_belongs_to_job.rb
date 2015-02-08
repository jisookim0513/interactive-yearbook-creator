class ImageBelongsToJob < ActiveRecord::Migration
  def change
    add_column :images, :job_id, :integer
    add_column :images, :metadata_id, :integer
  end
end
