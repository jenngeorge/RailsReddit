class SubsController < ApplicationController

  before_action :check_sub_owner, only: [:update, :edit]



  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    @sub.user_id = current_user.id

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.includes(:posts).find_by_id(params[:id])
    render :show
  end

  private

  def check_sub_owner
    @sub = Sub.find_by_id(params[:id])
    unless @sub.user_id == current_user.id
      flash[:errors] = ["You cannot edit a sub that does not belong to you :("]
      redirect_to sub_url(@sub)
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description, :user_id)
  end
end
