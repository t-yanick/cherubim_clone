class DepositsController < ApplicationController
  before_action :set_my_current_user
  before_action :set_deposit, only: %i[show edit update destroy]

  # GET /deposits or /deposits.json
  def index
    @deposits = Deposit.all
    authorize @deposit
  end

  # GET /deposits/1 or /deposits/1.json
  def show; end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit; end

  # POST /deposits or /deposits.json
  def create
    @deposit = Deposit.new(deposit_params)
    if @deposit.good
      @deposit.amount = @deposit.good.price
    end
   
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

  def set_my_current_user
    Current.user = current_cherubim_user
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
end
