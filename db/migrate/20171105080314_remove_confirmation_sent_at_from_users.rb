class RemoveConfirmationSentAtFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :confirmation_sent_at, :datetime
  end
end
