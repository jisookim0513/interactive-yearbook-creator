class AddAttachmentToJob < ActiveRecord::Migration
  def self.up
    add_attachment :jobs, :file
  end

  def self.down
    remove_attachment :jobs, :file
  end
end
