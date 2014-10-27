class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy

	before_save { email.downcase! }
	before_create :create_remember_token

	validates :name,	presence: true,
						length: { maximum: 50 }
	Valid_Email_Regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email,	presence: 	true, 
						format: 	{ with: Valid_Email_Regex }, 
						uniqueness: { case_sensitive: false }
	validates :password,length: { minimum: 6 }
	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		# このコードは実装段階です。
		# 完全な実装は第11章「ユーザーをフォローする」を参照してください。

		# この疑問符はSQLインジェクション対策の効果がある。これまでにこの話題が上がらなかったのは、
		# form_forやform_tagがSQLインジェクションを防止する効果があったからだろうか？

		Micropost.where("user_id = ?", id)	
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
