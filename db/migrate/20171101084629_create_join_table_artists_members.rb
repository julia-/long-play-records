class CreateJoinTableArtistsMembers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :artists, :members do |t|
      t.index [:artist_id, :member_id], unique: true
      t.index [:member_id, :artist_id], unique: true
    end
  end
end
