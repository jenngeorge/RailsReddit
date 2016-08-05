class CommentsController < ApplicationController

  before_action :check_logged_in

  def new
    @comment = Comment.new
    @post = Post.find_by_id(params[:id])
    @parent_comment_id = params[:parent_comment_id]

  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_url(@comment.post)
    else
      fail
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  private

  def check_logged_in
    unless current_user
      flash[:errors] = ["You must log in before commenting!"]
      redirect_to new_session_url
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
