class VotesController < ApplicationController

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private

  def vote(value)
    @vote = Vote.find_or_create_by({
      user_id: current_user.id,
      votable_type: params[:votable_type],
      votable_id: params[:votable_id]
      })
    @vote.value = value
    if @vote.save
      redirect_to :back
    else
      flash[:error] = @vote.errors.full_messages
      redirect_to :back
    end
  end

end #class end
