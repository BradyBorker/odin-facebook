class RemoveReferencesFromLikes < ActiveRecord::Migration[7.0]
  def change
      remove_column :likes, :user_id
      remove_column :likes, :post_id
  end
end
