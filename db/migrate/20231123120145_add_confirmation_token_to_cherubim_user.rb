class AddConfirmationTokenToCherubimUser < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :confirmation_token, :string
  end
end
