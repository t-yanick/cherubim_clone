class Customer < ApplicationRecord
  has_many :goods
  validates :email, prescence: true, uniqueness: true
  validates :telephone, prescence: true, uniqueness: true
  validates_presence_of :first_name, :last_name, :country, :address, :city
  def name_with_initial
    "#{first_name} #{last_name} #{email}"
  end
end
