class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.string :title
      t.string :description
      t.date :delivery_date
      t.decimal :price
      t.integer :pieces
      t.integer :project_id
      t.integer :image_id

      t.timestamps
    end
  end
end
