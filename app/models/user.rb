class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_one :user_information
  accepts_nested_attributes_for :user_information

  def friend_invitations_count
    inverse_friendships.where(pending: true).count.to_s
  end

  def display_name
    "#{user_information.first_name} #{user_information.last_name}"
  end
end
