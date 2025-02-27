class CreateOrderDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :order_details do |t|
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :order_id, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
