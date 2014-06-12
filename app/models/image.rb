class Image < ActiveRecord::Base
	belongs_to :gallery
	validates :image_url, :galery_id, presence:true
end
