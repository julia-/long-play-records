class RemovePostageFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :postage, :float
  end
end
