class GoodsController < ApplicationController
  include GoodsHelper
  before_action :set_good, only: %i[show edit update destroy]

  # GET /goods or /goods.json
  def index
    @goods = Good.all
    authorize @goods
  end

  # GET /goods/1 or /goods/1.json
  def show; end

  # GET /goods/new
  def new
    @good = Good.new
    authorize @good
  end

  # GET /goods/1/edit
  def edit; end

  # POST /goods or /goods.json
  def create
    @good = Good.new(good_params)
    @good.price = @good.weight * @good.unit_price
    respond_to do |format|
      if @good.save
        format.html { redirect_to good_url(@good), notice: 'Good was successfully created.' }
        format.json { render :show, status: :created, location: @good }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goods/1 or /goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to good_url(@good), notice: 'Good was successfully updated.' }
        format.json { render :show, status: :ok, location: @good }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1 or /goods/1.json
  def destroy
    @good.destroy

    respond_to do |format|
      format.html { redirect_to goods_url, notice: 'Good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_good
    @good = Good.find(params[:id])
    authorize @good
  end

  # Only allow a list of trusted parameters through.
  def good_params
    params.require(:good).permit(:weight, :name, :status_received, :customer_id,:unit_price)
  end
end
