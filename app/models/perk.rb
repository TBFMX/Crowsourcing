class Perk < ActiveRecord::Base
	belongs_to :project
	#belongs_to :image

	validates :title, :description, :delivery_date, :price,:project_id, presence:true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
end
