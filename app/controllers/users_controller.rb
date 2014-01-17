class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: :destroy
  def new
    @user = User.new
  end

	def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

 	def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

	def show
    @user = User.find(params[:id])
		#correct_user # maybe use this later if you want to limit page access to only the user
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
			sign_in @user
			flash[:success] = "Welcome to Eudora!"
       # Tell the UserMailer to send a welcome Email after save
       UserMailer.welcome_email(@user).deliver
      redirect_to @user
    else
      render 'new'
    end
  end

	private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

		# Before filters

    def signed_in_user
			store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

 		def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

 		def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
