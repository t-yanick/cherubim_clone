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
    authorize @customer, :new?
  end

  def create_only_customer
    @customer = Customer.new(customer_params)
    authorize @customer, :create?
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        flash[:notice] = @customer.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def index_c_g
    puts "Country Filter: #{params[:country_filter]}"

    @customers = Customer.includes(:goods)

    @customers = @customers.where(country: params[:country_filter]) if params[:country_filter].present?
    respond_to do |format|
      format.html { render partial: 'index_c_g', locals: { customers: @customers } }
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

  def generate_pdf
    customers = Customer.where(created_at: Date.current.beginning_of_week..Date.current.end_of_week)
    pdf = Prawn::Document.new

    pdf.text 'Weekly Customer and Goods Listing', size: 20, align: :center
    pdf.move_down 20

    week_code = customers.first.created_at.strftime('%Y-W%U')
    pdf.text "Week Code: #{week_code}", size: 14, style: :bold
    pdf.move_down 10

    customers.each do |customer|
      pdf.text "Date: #{customer.created_at.strftime('%Y-%m-%d')}", size: 12

      pdf.text "Name: #{customer.first_name} #{customer.last_name}", size: 12
      pdf.text "Telephone: #{customer.telephone}", size: 12
      pdf.text "Email: #{customer.email}", size: 12
      pdf.text "Address: #{customer.address}", size: 12
      pdf.text "Country: #{customer.country}", size: 12

      pdf.text 'Goods:', size: 12, style: :bold
      customer.goods.each do |good|
        pdf.text "Good name: #{good.name}", size: 12
        pdf.text "Weight of good #{good.weight}", size: 12
      end

      pdf.move_down 20
    end

    send_data pdf.render, filename: "cherubim_listing_#{week_code}.pdf", type: 'application/pdf'
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
                                     goods_attributes: %i[weight status_received name unit_price])
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
