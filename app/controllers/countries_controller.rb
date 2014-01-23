class CountriesController < ApplicationController
	include SessionsHelper
  #before_action :admin_user,     only: [:new, :create,:destroy]

	def show
    @country = Country.find(params[:id])
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)    # Not the final implementation!
    if @country.save
			flash[:success] = "New Country Added!"
       # Tell the UserMailer to send a welcome Email after save
      redirect_to @country
    else
      render 'new'
    end
  end

	private

    def country_params
      params.require(:country).permit(:name)
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

end # end country
