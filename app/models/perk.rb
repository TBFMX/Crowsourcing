class Perk < ActiveRecord::Base
	belongs_to :project

	belongs_to :image
	has_many :funders

	#validates_size_of :image_id, maximum: 60.kilobytes , message: "el tamaño de la imagen no deve exceder los 60KB"  
	# validate :picture_size_validation, :if => "image_id?"  

 #  def picture_size_validation
 #    errors[:image_id] << "el peso de la imagen no deve exceder los 60KB" if image_id.size > 60.kilobytes
 # end

	#validates :title, :description, :delivery_date, :price,
	#validates :project_id, presence:true
	#validates :price, numericality: {greater_than_or_equal_to: 0.01}
end
