class CommentsController < ApplicationController

	before_filter :authenticate_user! , except: [:index, :show]

	def index
		@page = params[:page]
		@post = Post.friendly.find(params[:post_id])
		redirect_to post_path(@post, :page => @page)
	end

	




	 def create
		# Create new comment record to DB
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@post = Post.friendly.find(params[:post_id])
		@comment.post_id = @post.id

		

		# For showing the post
		

		
		@user = User.find_by_id(@post.user_id)
		@email = @user.email

		@comments = @post.comments.order('created_at DESC').paginate(:per_page => 2, :page => params[:page])
		respond_to do |format|

			if user_signed_in?



				if @post.comments.count >9
				format.js {
					render 'warnCount'
				}
		else
			# Save the comment
		if @comment.save

	NewsletterMailer.delay.weekly(@email,@comment, request.original_url)




	  			format.js { 
    				render "create"
				}
			
		else format.js {
			render 'warnContent'
		}

		end

		end


			else format.js {
				render 'warnLogin'
			}
				
			end

			end	
	end


	def destroy
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private 
		def comment_params
			params.require(:comment).permit(:body)
			
		end

end
