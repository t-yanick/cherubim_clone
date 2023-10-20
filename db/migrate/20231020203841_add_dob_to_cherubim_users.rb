class AddDobToCherubimUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :Dob, :date
  end
end
