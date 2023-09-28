class CreateFriendInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_invitations do |t|
      t.references :sender
      t.references :receiver
      t.boolean :pending
      t.timestamps
    end
  end
end
