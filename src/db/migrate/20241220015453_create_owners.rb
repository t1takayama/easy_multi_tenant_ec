class CreateOwners < ActiveRecord::Migration[8.0]
  def change
    create_table :owners do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :tenant_id, null: false

      t.timestamps
      t.index :email, unique: true
    end

  end
end
