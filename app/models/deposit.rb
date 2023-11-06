class Deposit < ApplicationRecord
  belongs_to :customer
  belongs_to :good, optional: true
  after_save :generate_receipt
  has_one :receipt

  private

  def generate_receipt
    deposit = Deposit.last.good
    if deposit
      Receipt.create!(cherubim_user_id: Current.user.id,
                      good_id: Deposit.last.good.id,
                      customer_id: Deposit.last.customer.id,
                      deposit_id: Deposit.last.id,
                      good_name: Deposit.last.good.name)

    else
      Receipt.create!(cherubim_user_id: Current.user.id,
                      customer_id: Deposit.last.customer.id,
                      deposit_id: Deposit.last.id)
    end
  end
end
