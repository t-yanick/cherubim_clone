class DepositsController < ApplicationController
  before_action :set_my_current_user
  before_action :set_deposit, only: %i[show edit update destroy]

  # GET /deposits or /deposits.json
  def index
    @deposits = Deposit.all
    authorize @deposits
    # @deposits = Deposit.where(customer_id: params[:search])
  end

  # GET /deposits/1 or /deposits/1.json
  def show
     @deposit =  Deposit.find(params[:id])
     # @good = @deposit.good
     @status = @deposit.received? ? 'received' : 'pending'
     @receipt = @deposit.receipt
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit; end

  # POST /deposits or /deposits.json
  def create
    @deposit = Deposit.new
    if deposit_params['good_id'].blank?
      new_deposit_params = deposit_params.except('good_id')
      @deposit = Deposit.new(new_deposit_params)
    else
      @deposit = Deposit.new(deposit_params)
      @deposit.amount = Good.find(deposit_params['good_id']).price
    end
    @deposit.status = 'received'

    authorize @deposit
    respond_to do |format|
      if @deposit.save
        format.html { redirect_to deposit_url(@deposit), notice: 'Deposit was successfully created.' }

        pdf_path = generate_pdf_receipt(@deposit) # Generate PDF receipt
        format.html { redirect_to deposit_url(@deposit), notice: 'Deposit was successfully created.' }
        format.json { render :show, status: :created, location: @deposit }
        format.pdf { send_pdf_receipt(pdf_path) } # Send PDF receipt as response
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deposits/1 or /deposits/1.json
  def update
    respond_to do |format|
      if @deposit.update(deposit_params)
        format.html { redirect_to deposit_url(@deposit), notice: 'Deposit was successfully updated.' }
        pdf_path = generate_pdf_receipt(@deposit) # Generate PDF receipt
        format.html { redirect_to deposit_url(@deposit), notice: 'Deposit was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposit }
        format.pdf { send_pdf_receipt(pdf_path) } # Send PDF receipt as response
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
      @deposit.status = 'received'  
    end
  end

  # DELETE /deposits/1 or /deposits/1.json
  def destroy
    @deposit.destroy

    respond_to do |format|
      format.html { redirect_to deposits_url, notice: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def statistics
    @deposits = Deposit.all
    @daily_total = calculate_daily_total
    @weekly_total = calculate_weekly_total
    @monthly_total = calculate_monthly_total
    @bi_quarterly_total = calculate_bi_quarterly_total
    @annual_total = calculate_annual_total
  end

  def set_my_current_user
    Current.user = current_cherubim_user
  end
  def print_weekly_statistics
    puts "yes"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deposit
    @deposit = Deposit.find(params[:id])
    authorize @deposit
  end

  # Only allow a list of trusted parameters through.
  # Only allow a list of trusted parameters through.
  def deposit_params
    params.require(:deposit).permit(:amount, :date, :customer_id, :good_id)
  end

  def generate_pdf_receipt(deposit)
    pdf = Prawn::Document.new

    pdf.text 'Deposit Receipt', size: 20, style: :bold
    pdf.move_down 20

    pdf.text "Amount: #{deposit.amount}"
    pdf.text "Date: #{deposit.date}"
    pdf.text "Customer ID: #{deposit.customer_id}"

    # Customize the PDF content as needed

    pdf_path = Rails.root.join('public', 'deposit_receipt.pdf')
    pdf.render_file(pdf_path)

    pdf_path
  end

  def send_pdf_receipt(pdf_path)
    send_file pdf_path, filename: 'deposit_receipt.pdf', type: 'application/pdf', disposition: 'inline'
  end

  def calculate_daily_total
    # deposits = Deposit.where(date: Date.today)
    daily_total = Hash.new(0)
    @deposits.each do |deposit|
      date = deposit.date.to_date
      daily_total[date] += deposit.amount if deposit.amount
    end
    daily_total
  end

  def calculate_weekly_total
    # deposits = Deposit.where('date BETWEEN ? AND ?',Date.today, Date.today-7)
    # weekly_total = 0
    #   deposits.each do |deposit|
    #     if deposit.amount
    #     weekly_total += deposit.amount
    #     end
    # end
    weekly_total = Hash.new(0)
    @deposits.each do |deposit|
      week_start = deposit.date.to_date.beginning_of_week
      weekly_total[week_start] += deposit.amount if deposit.amount
    end
    weekly_total
  end

  def calculate_monthly_total
    # deposits = Deposit.where('date < ?', Date.today.end_of_month)
    #  monthly_total = 0
    #   deposits.each do |deposit|
    #     if deposit.amount
    #      monthly_total += deposit.amount
    #     end
    # end
    monthly_total = Hash.new(0)
    @deposits.each do |deposit|
      month_start = deposit.date.to_date.beginning_of_month
      monthly_total[month_start] += deposit.amount if deposit.amount
    end
    monthly_total
  end

  def calculate_bi_quarterly_total
    bi_quarterly_total = Hash.new(0)
    @deposits.each do |deposit|
      quarter_start = deposit.date.to_date.beginning_of_quarter
      bi_quarterly_total[quarter_start] += deposit.amount if deposit.amount
    end
    bi_quarterly_total
  end

  def calculate_annual_total
    annual_total = Hash.new(0)
    @deposits.each do |deposit|
      year_start = deposit.date.to_date.beginning_of_year
      annual_total[year_start] += deposit.amount if deposit.amount
    end
    annual_total
  end
end
