class Good < ApplicationRecord
  belongs_to :customer
  has_one :deposit
  def name_with_initial
    "#{name} #{weight}"
  end
end
