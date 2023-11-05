class CreateGoods < ActiveRecord::Migration[7.0]
  def change
    create_table :goods do |t|
      t.decimal :weight
      t.decimal :price
      t.boolean :status_received
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
