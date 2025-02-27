class CreateTenants < ActiveRecord::Migration[8.0]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.integer :status, null: false, default: 1
      t.string :domain, null: false

      t.timestamps
      t.index :domain, unique: true
    end
  end
end
