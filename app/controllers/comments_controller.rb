class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy


  def create
  	@comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      @feed_items = []
      flash[:danger] = "Comment isn't blank"
      redirect_to request.referrer || root_url
    end
  end

  def destroy
  	@comment.destroy
    flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url

  end
  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :entry_id)
  end

    #confirm user
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

  end
