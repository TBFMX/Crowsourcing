class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.decimal :monetary_goal
      t.date :init_date
      t.date :finish_date

      t.timestamps
    end
  end
end
