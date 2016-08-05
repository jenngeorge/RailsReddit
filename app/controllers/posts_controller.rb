class PostsController < ApplicationController
  before_action :check_post_owner, only: [:update, :edit]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    @post.user_id = current_user.id

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.include(:author).find_by_id(params[:id])
    render :show
  end

  private

  def check_post_owner
    @post = Post.find_by_id(params[:id])
    unless @post.user_id == current_user.id
      flash[:errors] = ["You cannot edit a post that does not belong to you :("]
      redirect_to post_url(@post)
    end
  end

  def sub_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
