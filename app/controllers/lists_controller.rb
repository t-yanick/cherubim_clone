class ListsController < ApplicationController
  def search
    @country = search_params[:search]

    @weekly_customers = Customer.where(country: @country)
       puts " test starts"
       puts " test starts"

       @weekly_customers.each do |c|
        puts c.first_name
        puts c.country
       end
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
