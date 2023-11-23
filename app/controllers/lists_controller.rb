class ListsController < ApplicationController
  def search
    @country = search_params[:search]
    country    = ISO3166::Country.find_country_by_any_name(@country)
    @weekly_customers = Customer.where(country: country.alpha2).order( 'created_at DESC' )
  end
  def index
  end

  def show
  end
  private
  def search_params
    params.permit(:search,:commit, :Context)
  end
end
