class AddNicToCherubimUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :Nic, :string
  end
end
