class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :status

      t.timestamps
    end
  end
end
