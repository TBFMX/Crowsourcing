class User < ActiveRecord::Base
  has_secure_password
  validates :username, :password, :email, presence:true
end