class AddCountryToCherubimUser < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :country, :string
  end
end
