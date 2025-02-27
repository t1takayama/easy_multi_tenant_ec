class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :stock, null: false
      t.integer :tenant_id, null: false

      t.timestamps
    end
  end
end
