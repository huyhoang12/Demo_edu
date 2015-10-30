  class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
      :following, :followers]
      before_action :correct_user,   only: [:edit, :update]
      before_action :admin_user,     only: :destroy

      
      def show 
        @user= User.find(params[:id])
        @entries = @user.entries.paginate(page: params[:page],per_page: 5)
      end
  #--------------------------------
  def index
    @users = User.paginate(page: params[:page])
  end
  #--------------------------------

  def new
    @user= User.new
  end
  #--------------------------------
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # Handle a successful save.
    else
      render 'new'
    end
  end
#--------------------------

def edit
  @user = User.find(params[:id])
end
#--------------------------------------------------------------

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated"
    redirect_to @user
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  # Destroy users
  def destroy
    User.find(params[:id]).destroy
    flash[:success]= "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #--------------------------------------------------------------
  private
  def user_params
   params.require(:user).permit(:name, :email, :password,
     :password_confirmation)
   
 end

 def correct_user
  @user = User.find(params[:id])      
  redirect_to(root_url) unless current_user?(@user)

end

    #Confirms the admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


  end