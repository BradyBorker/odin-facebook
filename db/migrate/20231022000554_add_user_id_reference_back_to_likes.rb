class AddUserIdReferenceBackToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user
  end
end
