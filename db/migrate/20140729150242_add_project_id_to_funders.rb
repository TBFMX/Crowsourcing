class AddProjectIdToFunders < ActiveRecord::Migration
  def change
  	 add_column :funders, :project_id, :integer
  end
end
