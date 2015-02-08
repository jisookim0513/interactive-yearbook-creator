class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :facebook
      t.string :linkedin

      t.timestamps
    end
  end
end
