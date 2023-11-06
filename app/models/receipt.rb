class Receipt < ApplicationRecord
  belongs_to :deposit
  belongs_to :customer
  belongs_to :good, optional: true
  belongs_to :cherubim_user
end
