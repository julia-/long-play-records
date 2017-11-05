class RenameColumnNameinTableProducttoTitle < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :name, :title
  end
end
