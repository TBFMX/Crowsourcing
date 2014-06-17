class Amend < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	belongs_to :image
	#has_many :images
end
