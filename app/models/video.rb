class Video < ActiveRecord::Base
	belongs_to :gallery
	validates :video_url, :galery_id, presence:true
end
