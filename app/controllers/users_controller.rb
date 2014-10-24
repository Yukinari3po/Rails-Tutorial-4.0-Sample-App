class UsersController < ApplicationController
  before_action :redirect_for_non_signed_in_user,
                                  only: [:index, :edit, :update]
  before_action :redirect_for_signed_in_user,
                                  only: [:new, :create]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  # 以降、各actionが呼び出された時に呼び出される。
  def index
    @users = User.paginate(page: params[:page])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  	private

      # Webから変更・参照を許可するパラメータを設定する.
      # (Strong Parameters)
  		def user_params
  			params.require(:user).permit(	:name, 
  											:email,
  											:password,
  											:password_confirmation
                        )
  		end

      # Before Actions 
      def redirect_for_non_signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_url, notice: "Please sign in."
        end
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end

      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end

      def redirect_for_signed_in_user
        redirect_to(root_path) if signed_in?
      end
end
