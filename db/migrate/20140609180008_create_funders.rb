class CreateFunders < ActiveRecord::Migration
  def change
    create_table :funders do |t|
      t.integer :user_id
      t.integer :perk_id

      t.timestamps
    end
  end
end
