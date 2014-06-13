class Funder < ActiveRecord::Base
	belongs_to :user
	belongs_to :perk
	belongs_to :project

	def total_price
		perk.price
  	end
end
