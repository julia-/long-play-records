class AddCoverImagetoProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :cover_image, :string
  end
end
