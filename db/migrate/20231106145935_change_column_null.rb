class ChangeColumnNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :deposits, :good_id, null: true
  end
end
