class CreateReleases < ActiveRecord::Migration[5.1]
  def change
    create_table :releases do |t|
      t.string :title
      t.string :catalogue_number
      t.string :format
      t.string :country_code
      t.date :released_at
      t.text :image_data
      t.references :artist, foreign_key: true

      t.timestamps

      t.index :title
      t.index :catalogue_number
    end
  end
end
