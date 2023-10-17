class Receipt < ApplicationRecord
  belongs_to :customer
  belongs_to :deposit
end
