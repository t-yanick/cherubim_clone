class AddConfirmedToCherubimUser < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :confirmed, :boolean
  end
end
