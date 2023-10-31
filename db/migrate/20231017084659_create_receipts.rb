class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :deposit, null: false, foreign_key: true

      t.timestamps
    end
  end
end