class AddOutputToJobs < ActiveRecord::Migration
  def self.up
    add_attachment :jobs, :output
  end

  def self.down
    remove_attachment :jobs, :output
  end
end
