class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	validates :user_id, :project_id, :comments, presence:true
end