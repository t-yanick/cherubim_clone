class Customer < ApplicationRecord
  belongs_to :good
  has_many :deposits
end
