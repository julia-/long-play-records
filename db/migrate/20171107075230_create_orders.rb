class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :buyer, foreign_key: { to_table: :users }
      t.references :product, foreign_key: true
      t.string :charge_identifier

      t.timestamps
    end
  end
end
