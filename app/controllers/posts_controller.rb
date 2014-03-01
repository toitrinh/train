class PostsController < ApplicationController
	
before_filter :authenticate_user!, except: [:index, :show]

	

def index
 
  @posts = Post.order('created_at DESC').paginate(:per_page => 5, :page => params[:page])
		
end



	def new
		@post = Post.new
	end

	



	def create

	    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to root_url
    else
      render "new"
    end
  end




	def edit
		@post = Post.friendly.find(params[:id]) 
	end



	def update
		@post = Post.friendly.find(params[:id]) 

		if @post.update(params[:post].permit(:title, :text))
			redirect_to @post
		else
			render 'edit'
		end
	end


	def destroy
		@post = Post.friendly.find(params[:id]) 
		@post.destroy

		redirect_to posts_path
		
	end

	def show

			@post = Post.friendly.find(params[:id]) 

			@comments = @post.comments.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
		
		

		


	end

	private 
		def post_params
			params.require(:post).permit(:title, :text)
			
		end

end
