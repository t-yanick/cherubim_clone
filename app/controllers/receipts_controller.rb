class ReceiptsController < ApplicationController
    def show
        @receipt = Receipt.find(params[:id])
        authorize @receipt
    end
    private    
    def receipt_params
        params.require(:receipts).permit(:good_id,
            :customer_id,
            :deposit_id,
            :good_name,
            :cherubim_user_id)
    end
end
