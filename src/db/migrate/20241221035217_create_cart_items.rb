class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 1, null: false
      t.integer :customer_id, null: false
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
