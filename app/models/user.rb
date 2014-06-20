class User < ActiveRecord::Base
  has_secure_password
  validates :username, :password, :email, presence:true

    def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
    #se le agrego el paramatro de que no validara 
	  save!(:validate => false)
	  Mailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  private
	def ensure_an_admin_remains
		if User.count.zero?
			raise "Can't delete last user"
		end
	end
end