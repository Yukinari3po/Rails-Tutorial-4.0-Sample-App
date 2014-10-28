class User < ActiveRecord::Base
	has_many :microposts,
							dependent: :destroy
	
	# テーブル同士の関連付けを示す外部キーがuser_idで表せないため、このように明示して指定している
	has_many :relationships, 
							foreign_key: "follower_id", 
							dependent: :destroy
	
	has_many :followed_users,
							through: :relationships, 
							source: :followed

	# ReverseRelationshipクラスは無いので、class名の指定を行っている。
	# また、上述のfollowedと関連をつけるためにsourceを明示的にしているが、省略可能である。
	has_many :reverse_relationships,
							foreign_key: "followed_id",
							class_name: "Relationship",
							dependent: :destroy

	has_many :followers, 	
							through: :reverse_relationships,
							source: :follower

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

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		# 関数名の後に!をつけることによって例外が発生する。
		# self.relationships.create!()と同様の意味を表し、selfを記述するか
		# どうかは好み。
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
