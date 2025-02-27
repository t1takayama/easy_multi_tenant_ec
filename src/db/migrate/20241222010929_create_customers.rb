class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :status, null: false, default: 0
      t.integer :tenant_id, null: false

      t.timestamps
      t.index :email, unique: true
    end
  end
end
