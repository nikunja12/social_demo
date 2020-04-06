class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment= Comment.where(post_id: @post)
 end

  def new
    @post = Post.new
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id 
        if @post.save
            redirect_to @post
        else
            render 'new'
        end
  end
  
  def update
      @post = Post.find(params[:id])
       if @post.update(post_params)
         redirect_to @post
      else
         render :edit 
        
      end
  end
  
  def destroy
    if @post.present?
       @post.destroy
   end
     # redirect_to root_url
      redirect_to posts_path 
  end

  private
    def post_params
      params.require(:post).permit(:post,:user_id)
    end
end











