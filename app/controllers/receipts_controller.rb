class ReceiptsController < ApplicationController
    def show
        @receipt = Receipt.find(params[:id])
        authorize @receipt
    end

    def download
        @receipt = Receipt.find(params[:id])
        #authorize @receipt
    
        pdf_path = generate_pdf_receipt(@receipt)
        file_name = "#{@receipt.customer.first_name}#{@receipt.customer.last_name}_#{@receipt.id}.pdf"
        send_file pdf_path, filename: file_name, type: 'application/pdf', disposition: 'attachment'
      end
    private    
        def receipt_params
            params.require(:receipts).permit(:good_id,
                :customer_id,
                :deposit_id,
                :good_name,
                :cherubim_user_id)
        end

        def generate_pdf_receipt(receipt)
            pdf = Prawn::Document.new

            pdf.font_size 20
            pdf.text 'Deposit Receipt', style: :bold, align: :center
            pdf.move_down 20
          
            pdf.font_size 12
            pdf.text "Receipt Number: #{receipt.id}"
            pdf.move_down 10
            pdf.text "Customer ID: #{receipt.customer_id}"
            pdf.move_down 30
            pdf.text "Customer Name: #{receipt.customer.first_name} #{receipt.customer.last_name}"
            pdf.move_down 10
            pdf.text "Good Name: #{receipt.good_name}"
            pdf.move_down 10
            pdf.text "Amount: #{receipt.deposit.amount}"
            pdf.move_down 10
            pdf.text "Date: #{receipt.deposit.date}"
            pdf.move_down 30
            pdf.text "Issued by: #{receipt.cherubim_user.first_name} #{receipt.cherubim_user.last_name}"
            pdf.move_down 50
            pdf.text 'Sign', align: :left, size: 14, style: :italic
            pdf.move_down 20
            pdf.stroke_horizontal_rule
            pdf.text 'Customer sign', align: :right, size: 14, style: :italic
            pdf.move_down 20
            pdf.stroke_horizontal_rule

          
            pdf.move_down 20
            pdf.stroke_horizontal_rule
          
            pdf.move_down 20
            pdf.text 'Thank you for trusting Cherubim Express!', align: :center, size: 14, style: :italic
          
          
            pdf_path = Rails.root.join('public', "#{receipt.customer.first_name}.#{receipt.id}.pdf")
            pdf.render_file(pdf_path)
          
            pdf_path
        end
    end
