class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	#						uniqueness:true #does not account for uppercase differences
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

 validates :password_reset_token, uniqueness: { case_sensitive: true }, allow_nil:true
  has_secure_password
	validates :password, length: {minimum: 6}

	def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

	def send_password_reset
  	generate_token(:password_reset_token)
  	self.password_reset_sent_at = Time.zone.now
  	save!(:validate => false)
  	UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
  	begin
  	  self[column] = SecureRandom.urlsafe_base64
  	end while User.exists?(column => self[column])
	end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
