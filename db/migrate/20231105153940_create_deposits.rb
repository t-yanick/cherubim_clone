class CreateDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :deposits do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :amount
      t.date :date

      t.timestamps
    end
  end
end
