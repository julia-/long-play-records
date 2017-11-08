class RemoveSellerFromConversations < ActiveRecord::Migration[5.1]
  def change
    remove_reference :conversations, :seller, index: true, foreign_key: { to_table: :users }
  end
end
