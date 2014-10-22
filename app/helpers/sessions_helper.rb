module SessionsHelper
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def current_user=(user) # 演算子のオーバーライドのようなもの
		@current_user = user
	end


	# current_user
	# 
	# #ユーザーのブラウザに記録されたトークンを受け取り、暗号化してremember_tokenに代入する。
	# remember_tokenを使用してユーザー一覧から検索し、@current_userが未定義の時にのみ代入する。
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])　		
		@current_user ||= User.find_by(remember_token: remember_token)  
	end
end
