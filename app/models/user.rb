class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :sent_invitations, class_name: 'FriendInvitation', foreign_key: :sender_id, dependent: :destroy
  has_many :received_invitations, class_name: 'FriendInvitation', foreign_key: :receiver_id

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_one :user_information, dependent: :destroy
  accepts_nested_attributes_for :user_information

  scope :not_friends, ->(current_user) { where.not(id: Friendship.where(user_id: current_user).uniq.pluck(:friend_id).push(current_user)) }

  def friend_invitations_count
    received_invitations.count.to_s
  end

  def display_name
    "#{user_information.first_name} #{user_information.last_name}"
  end
end
