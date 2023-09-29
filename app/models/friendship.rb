class Friendship < ApplicationRecord
  validates :user_id, uniqueness: { scope: :friend_id }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.create_friendship(users)
    @first_connection = Friendship.find_or_create_by(user_id: users[:current_user], friend_id: users[:friend])
    @second_connection = Friendship.find_or_create_by(user_id: users[:friend], friend_id: users[:current_user])

    @first_connection && @second_connection ? true : false
  end
end
