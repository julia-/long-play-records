class AddPostageCentsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :postage_cents, :integer
  end
end
