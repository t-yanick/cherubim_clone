class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.references :deposit, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :good, null: false, foreign_key: true
      t.references :cherubim_user, null: false, foreign_key: true
      t.string :good_name

      t.timestamps
    end
  end
end
