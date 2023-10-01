class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :sent_invitations, class_name: 'FriendInvitation', foreign_key: :sender_id
  has_many :received_invitations, class_name: 'FriendInvitation', foreign_key: :receiver_id

  has_many :posts

  has_many :likes

  has_many :comments

  has_one :user_information
  accepts_nested_attributes_for :user_information

  scope :not_friends, ->(current_user) { where.not(id: Friendship.where(user_id: current_user).pluck(:friend_id).uniq.push(current_user)) }

  def friend_invitations_count
    received_invitations.count.to_s
  end

  def display_name
    "#{user_information.first_name} #{user_information.last_name}"
  end
end
