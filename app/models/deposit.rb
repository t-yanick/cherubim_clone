class Deposit < ApplicationRecord
  belongs_to :customer
  belongs_to :goods, optional: true
end
