class UpdateJobFields < ActiveRecord::Migration
  def change
    remove_column :jobs, :school
    remove_column :jobs, :class_year
    add_column :jobs, :info, :text
  end
end
