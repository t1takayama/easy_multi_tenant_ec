class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :address, null: false
      t.integer :postage, null: false
      t.integer :billing_amount, null: false
      t.integer :status, null: false, default: 0
      t.integer :customer_id, null: false
      t.integer :payment_method, null: false

      t.timestamps
    end
  end
end
