class Image < ActiveRecord::Base
	belongs_to :gallery
	has_many :perks
	#validates :image_url, :galery_id, presence:true
end
