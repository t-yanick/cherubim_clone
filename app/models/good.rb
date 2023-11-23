class Good < ApplicationRecord
  belongs_to :customer
  has_one :deposit
  validates_presence_of :weight, :name
  def name_with_initial
    "#{name} #{weight}"
  end
end
