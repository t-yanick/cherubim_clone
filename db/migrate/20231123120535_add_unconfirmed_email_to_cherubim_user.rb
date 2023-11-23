class AddUnconfirmedEmailToCherubimUser < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :unconfirmed_email, :string
  end
end
