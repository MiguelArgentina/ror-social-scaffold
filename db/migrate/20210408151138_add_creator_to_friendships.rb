class AddCreatorToFriendships < ActiveRecord::Migration[6.1]
  def change
    add_column :friendships, :creator, :integer
  end
end
