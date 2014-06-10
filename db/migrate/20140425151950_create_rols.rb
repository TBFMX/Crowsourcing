class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :rol_name
      t.boolean :admin
      t.boolean :module_1
      t.boolean :module_2
      t.boolean :module_3
      t.boolean :module_4
      t.boolean :module_5

      t.timestamps
    end
  end
end
