class AddArtistToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :artist, :string
    add_index :products, :artist
  end
end
