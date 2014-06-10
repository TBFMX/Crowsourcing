class CreateAmends < ActiveRecord::Migration
  def change
    create_table :amends do |t|
      t.integer :user_id
      t.text :description
      t.integer :project_id
      t.integer :image_id

      t.timestamps
    end
  end
end
