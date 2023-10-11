class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.boolean :superadmin
      t.boolean :admin
      t.boolean :employer
      t.references :cherubim_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
