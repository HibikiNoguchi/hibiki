class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :instagram

  has_many :comment_likes, dependent: :destroy
  has_many :comment_liked_users, through: :likes, source: :user
end
