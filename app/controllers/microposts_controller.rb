class MicropostsController < ApplicationController
	before_action :redirect_for_non_signed_in_user
	before_action :redirect_for_non_correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy 
		@micropost.destroy
		redirect_to root_url
	end

private
	def micropost_params
		params.require(:micropost).permit(:content)
	end	

	def redirect_for_non_correct_user
		# findを用いると例外が発生するため、find_byを用いている。
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url if @micropost.nil?
	end
end