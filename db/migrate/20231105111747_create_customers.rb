class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :telephone
      t.string :email
      t.string :address
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
