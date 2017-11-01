class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :username
      t.string :first_name
      t.string :last_name
      t.text :image_data

      t.timestamps
      
      t.index :username, unique: true
    end
  end
end
