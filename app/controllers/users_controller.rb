class UsersController < ApplicationController
	def show
    @user = User.find(params[:id])

     @posts = @user.posts.order('created_at DESC').paginate(:per_page => 5, :page => params[:page])

  end
end
