class AddPriceCentsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :price_cents, :integer
    add_index :products, :price_cents
  end
end
