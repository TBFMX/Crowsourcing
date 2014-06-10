class Rol < ActiveRecord::Base
	has_many :users
	validates :rol_name, 
              presence: true,
            uniqueness: true
end
