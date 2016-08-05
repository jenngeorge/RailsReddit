class PostsController < ApplicationController
  before_action :check_post_owner, only: [:update, :edit]
  before_action :check_logged_in, only: [:create, :new]



  def new
    @post = Post.new
    @subs = Sub.all
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
    @subs = Sub.all
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
    @post = Post.includes(:author, :subs).find_by_id(params[:id])
    @comments = @post.comments.where(parent_comment_id: nil)
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

  def check_logged_in
    unless current_user
      flash[:errors] = ["You must log in before creating a post!"]
      redirect_to new_session_url
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
