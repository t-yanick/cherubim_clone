class AddUnitPriceToGoods < ActiveRecord::Migration[7.0]
  def change
    add_column :goods, :unit_price, :decimal
  end
end
