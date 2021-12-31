class AddUserIdToInstagrams < ActiveRecord::Migration[6.1]
  def change
    add_column :instagrams, :user_id, :integer
  end
end
