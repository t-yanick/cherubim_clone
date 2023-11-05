class Role < ApplicationRecord
  store_attribute :permissions, :create_customers, :boolean, default: false
  store_attribute :permissions, :read_customers, :boolean, default: false
  store_attribute :permissions, :update_customers, :boolean, default: false
  store_attribute :permissions, :delete_customers, :boolean, default: false

  store_attribute :permissions, :create_goods, :boolean, default: false
  store_attribute :permissions, :read_goods, :boolean, default: false
  store_attribute :permissions, :update_goods, :boolean, default: false
  store_attribute :permissions, :delete_goods, :boolean, default: false

  store_attribute :permissions, :create_deposits, :boolean, default: false
  store_attribute :permissions, :read_deposits, :boolean, default: false
  store_attribute :permissions, :update_deposits, :boolean, default: false
  store_attribute :permissions, :delete_deposits, :boolean, default: false

  store_attribute :permissions, :create_receipts, :boolean, default: false
  store_attribute :permissions, :read_receipts, :boolean, default: false
  store_attribute :permissions, :update_receipts, :boolean, default: false
  store_attribute :permissions, :delete_receipts, :boolean, default: false

  store_attribute :permissions, :create_roles, :boolean, default: false
  store_attribute :permissions, :read_roles, :boolean, default: false
  store_attribute :permissions, :update_roles, :boolean, default: false
  store_attribute :permissions, :delete_roles, :boolean, default: false
  #   has_many :cherubim_users
end
