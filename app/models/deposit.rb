class Deposit < ApplicationRecord
  belongs_to :customer
  belongs_to :good, optional: true
  after_save :generate_receipt
  has_one :receipt

  private

  def generate_receipt
    deposit = Deposit.last.good
    if deposit
      Receipt.create!(cherubim_user_id: 1,
                      good_id: Deposit.last.good.id,
                      customer_id: Deposit.last.customer.id,
                      deposit_id: Deposit.last.id,
                      good_name: Deposit.last.good.name)

    else
      Receipt.create!(cherubim_user_id: 1,
                      customer_id: Deposit.last.customer.id,
                      deposit_id: Deposit.last.id,
                      good_name: Deposit.last.good.name)
    end
  end
end
