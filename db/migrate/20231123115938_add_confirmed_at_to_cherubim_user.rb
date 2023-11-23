class AddConfirmedAtToCherubimUser < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :confirmed_at, :datetime
  end
end
