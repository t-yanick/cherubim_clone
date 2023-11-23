class AddConfirmationSentAtToCherubimUser < ActiveRecord::Migration[7.0]
  def change
    add_column :cherubim_users, :confirmation_sent_at, :datetime
  end
end
