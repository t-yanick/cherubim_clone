class AddGoodsToDeposits < ActiveRecord::Migration[7.0]
  def change
    add_reference :deposits, :good, null: true, foreign_key: true
  end
end
