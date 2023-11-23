class Deposit < ApplicationRecord
  belongs_to :customer
  belongs_to :good, optional: true
  validates_presence_of :amount
  after_save :generate_receipt
  has_one :receipt
  enum status: { pending: 0, received: 1, rejected: 2 }

  def received?
    status == 'received'
  end

  private

  def generate_receipt
    deposit = Deposit.last.good
    if deposit
      deposit.update(status_received: true)
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
