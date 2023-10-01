class Post < ApplicationRecord
  validates :body, presence: true

  belongs_to :user

  has_many :likes

  has_many :comments

  scope :timeline_posts, ->(current_user) { where(user_id: Friendship.where(user_id: current_user).pluck(:friend_id).uniq.push(current_user)).order(created_at: :desc) }
end
