class Funder < ActiveRecord::Base
	belongs_to :user
	belongs_to :perk
end
