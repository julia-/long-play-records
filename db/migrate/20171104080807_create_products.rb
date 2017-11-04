class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.float :postage
      t.string :record_condition
      t.string :sleeve_condition
      t.string :discogs_id
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps

      t.index :name
      t.index :price
      t.index :discogs_id
    end
  end
end
