class Friendship < ApplicationRecord
  validates :user_id, uniqueness: { scope: :friend_id }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :inverse_friendship_exists

  private

  def inverse_friendship_exists
    # Check to see if the inverse friendship exists. If it does
    ## Set pending to false and save
    ## Get inverse friendship and set pending to false and save
  end
end
