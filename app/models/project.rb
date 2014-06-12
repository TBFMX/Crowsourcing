class Project < ActiveRecord::Base
	validates :name, :image, :monetary_goal, :init_date,:finish_date, presence:true
	validates :monetary_goal, numericality: {greater_than_or_equal_to: 0.01}
end