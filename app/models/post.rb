class Post < ApplicationRecord
  validates :body, presence: true, unless: -> { image.attached? }

  belongs_to :user

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_one_attached :image

  scope :timeline_posts, ->(current_user) { where(user_id: Friendship.where(user_id: current_user).pluck(:friend_id).uniq.push(current_user)).order(created_at: :desc) }
end
