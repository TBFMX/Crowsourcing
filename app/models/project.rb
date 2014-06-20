class Project < ActiveRecord::Base
	has_many :funders, dependent: :destroy
	has_many :perks , dependent: :destroy
	has_many :images	
	has_many :galeries, dependent: :destroy
	validates :name, :monetary_goal, presence:true
	validates :monetary_goal, numericality: {greater_than_or_equal_to: 0.01}
	#validates_size_of :image_id, maximum: 60.kilobytes, message: "el tamaño de la imagen no deve exceder los 60KB"  
	 validate :picture_size_validation, :if => "image_id?"  

 	  def picture_size_validation
 	    errors[:image_id] << "el peso de la imagen no deve exceder los 60KB" if image_id.size > 60.kilobytes
 	  end

	def Total_actual
		#@founders = Founder.where('project_id' => @project)
		#@total = 0
		#@founders.each do |f|
		#	@total += f.perk.price
		#end	
		funders.to_a.sum { |item| item.total_price }
	end	
end