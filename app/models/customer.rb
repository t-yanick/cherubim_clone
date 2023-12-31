class Customer < ApplicationRecord
  has_many :goods, dependent: :destroy
  accepts_nested_attributes_for :goods, allow_destroy: true
  has_many :deposits
  validates :email, presence: true, uniqueness: true
  validates :telephone, presence: true, uniqueness: true
  validates_presence_of :first_name, :last_name, :country, :address, :city
  def name_with_initial
    "#{first_name} #{last_name} #{email}"
  end
end
