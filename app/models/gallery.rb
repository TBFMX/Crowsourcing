class Gallery < ActiveRecord::Base
	belongs_to :project
	#validates :title, :description, :project_id, presence:true
end