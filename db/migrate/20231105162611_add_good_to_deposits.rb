class AddGoodToDeposits < ActiveRecord::Migration[7.0]
  def change
    add_reference :deposits, :good, null: false, foreign_key: true
  end
end
