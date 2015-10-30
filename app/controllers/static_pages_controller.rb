class StaticPagesController < ApplicationController
  def home
  	if logged_in?
      @entry  = current_user.entries.build
      @comment  = current_user.comments.build

    end
    if current_user.nil?
      @feed_items = Entry.all.paginate(page: params[:page], per_page: 5)  
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)  
    end
  end
  
  def help
  end
  
  def about
  end

  def contact
  end
end
