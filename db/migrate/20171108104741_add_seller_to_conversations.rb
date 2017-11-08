class AddSellerToConversations < ActiveRecord::Migration[5.1]
  def change
    add_reference :conversations, :seller, index: true, foreign_key: { to_table: :products }
  end
end
