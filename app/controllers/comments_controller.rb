class CommentsController < ApplicationController
load_and_authorize_resource :nested => :post
 before_action :find_post

 def create
 	@comment=@post.comments.create(comment_params)
 	@comment.user_id= current_user.id
 	@comment.save
 	if @comment.save
 		redirect_to post_path(@post)
 	else
 		render 'new'
 	end
 end

 def destroy
 	@comment =@post.comments.find(params[:id])
 	@comment.destroy
 	redirect_to post_path(@post)
 	
 end

 def edit
 	
 	@comment =@post.comments.find(params[:id])
 end

 def update
 	@comment =@post.comments.find(params[:id])
 	if @comment.update(comment_params)
 		redirect_to post_path(@post)
 	else
 		render 'edit'
 	end
 end





private
 def find_post
 	@post= Post.find(params[:post_id])
 end

 def comment_params
    params.require(:comment).permit(:content,:post_id,:user_id)
 end

end
