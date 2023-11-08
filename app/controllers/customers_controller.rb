class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]
  include GoodsHelper
  # GET /customers or /customers.json
  def index
    @customers = Customer.all
    authorize @customers
  end

  # GET /customers/1 or /customers/1.json
  def show; end

  # GET /customers/new
  def new
    @customer = Customer.new
    # @customer = @customer.goods.new
    @customer.goods.new
    authorize @customer
  end

  def new_customer_only
    @customer = Customer.new
    # authorize @customer
  end

  def create_only_customer
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /customers/1/edit
  def edit; end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)
    authorize @customer
    respond_to do |format|
      if @customer.save
        last_good = Good.last
        last_good.price = last_good.weight * unit_price
        last_good.save
        format.html { redirect_to customer_url(@customer), notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
    authorize @customer
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:first_name,
                                     :last_name,
                                     :telephone,
                                     :email,
                                     :address,
                                     :country,
                                     :city,
                                     goods_attributes: %i[weight status_received name])
  end

  def customer_only_params
    params.require(:customer).permit(:first_name,
                                     :last_name,
                                     :telephone,
                                     :email,
                                     :address,
                                     :country,
                                     :city)
  end
end
