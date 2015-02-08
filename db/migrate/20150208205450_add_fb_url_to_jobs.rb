class AddFbUrlToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :fb_url, :text
  end
end
