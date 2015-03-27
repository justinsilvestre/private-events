class User < ActiveRecord::Base
	attr_accessor :remember_token
	has_secure_password
	has_many :events, foreign_key: 'creator_id'
	has_many :attendances, foreign_key: :attendee_id, dependent: :destroy
	has_many :attended_events, through: :attendances, foreign_key: :attendee_id
	before_save :downcase_email
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true

	# automatically set event creator as attending event, maybe?

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def rsvp(event)

	end

	def unrsvp(event)
		
	end

	def attending?(event)
		attended_events.any? do |e|
			event.id == e.id
		end	
	end

	private

		def downcase_email
			self.email = email.downcase
		end
end
