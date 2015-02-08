class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :email

      t.timestamps
    end
  end
end
