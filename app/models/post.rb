class Post < ApplicationRecord
  validates :body, presence: true

  belongs_to :user

  has_many :likes

  has_many :comments
end
