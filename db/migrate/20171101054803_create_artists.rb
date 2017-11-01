class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :biography
      t.text :image_data
      t.string :discog_number

      t.timestamps

      t.index :name
    end
  end
end
