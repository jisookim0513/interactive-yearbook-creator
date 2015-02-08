class AddSchoolToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :school, :text
    add_column :jobs, :class_year, :integer
  end
end
