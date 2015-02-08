class AddAttachmentToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :original
    add_attachment :images, :watermarked
  end

  def self.down
    remove_attachment :images, :original
    remove_attachment :images, :watermarked
  end
end
