class CreateDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :deposits do |t|
      t.decimal :amount
      t.datetime :date
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
