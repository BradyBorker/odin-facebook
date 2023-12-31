class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false
      t.references :friend, null: false
      t.boolean :pending

      t.timestamps
    end
  end
end
