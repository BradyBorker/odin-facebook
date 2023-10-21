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

  has_one_attached :profile_picture

  scope :not_friends, ->(current_user) { where.not(id: Friendship.where(user_id: current_user).uniq.pluck(:friend_id).push(current_user)) }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.user_information.first_name = auth.info.first_name
      user.user_information.last_name = auth.info.last_name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def friend_invitations_count
    received_invitations.count.to_s
  end

  def display_name
    "#{user_information.first_name} #{user_information.last_name}"
  end
end
