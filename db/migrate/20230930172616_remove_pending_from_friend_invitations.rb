class RemovePendingFromFriendInvitations < ActiveRecord::Migration[7.0]
  def change
    remove_column :friend_invitations, :pending, :boolean
  end
end
