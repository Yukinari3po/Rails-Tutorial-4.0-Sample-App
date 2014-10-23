class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    # 全てのuserを読み出して変数に格納している。 動作が重い。
    @users = User.all
  end

	def show 
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  # user_paramsを用いることでマスアサインメントの脆弱性を防止している。
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

	def create
		@user = User.new(user_params) 
		if @user.save
      sign_in @user
			flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
	  else
      render 'new'
	  end
	end

  	private

  		def user_params
  			params.require(:user).permit(	:name, 
  											:email,
  											:password,
  											:password_confirmation)
  		end

      # Before Actions 
      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
end
