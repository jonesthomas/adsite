class CountriesController < ApplicationController

  before_action :authenticate, except:[ :index, :show ]
  def show
    @country = Country.find(params[:id])
  end

  def new
		@country = Country.new
  end

 	def update
    @country = Country.find(params[:id])
    if @country.update_attributes(country_params)
      flash[:success] = "Country updated"
      redirect_to @country
    else
      render 'edit'
    end
  end

	def edit
		    @country = Country.find(params[:id])
  end

  def create
    @country = Country.new(country_params)    # Not the final implementation!
    if @country.save

			flash[:success] = "New Country!"
      redirect_to @country
    else
      render 'new'
    end
  end

	def index
    @countries = Country.paginate(page: params[:page])
		#@blogs=Blog.all
	end

private

    def country_params
      params.require(:country).permit(:name)
    end

	  private
  	
		def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == "admin1" && password == "ILcorporations1234!!"
    end
  end
end
