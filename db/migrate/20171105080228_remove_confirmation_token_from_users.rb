class RemoveConfirmationTokenFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :confirmation_token, :string
  end
end
