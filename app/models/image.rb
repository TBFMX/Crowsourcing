class Image < ActiveRecord::Base
	belongs_to :gallery
	has_many :perks
	validates :image_url, :galery_id, presence:true
	#validates_size_of :image_url, maximum: 60.kilobytes, message: "el tamaño de la imagen no deve exceder los 60KB"  
  	validate :picture_size_validation, :if => "image_url?"  

  	def picture_size_validation
  	  errors[:image_url] << "el peso de la imagen no deve exceder los 60KB" if image_url.size > 60.kilobytes
  	end
end
