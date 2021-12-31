class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :instagrams, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_instagrams, through: :likes, source: :instagram
  has_many :comments, dependent: :destroy
  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 

  mount_uploader :image, ImageUploader


  def already_liked?(instagram)
    self.likes.exists?(instagram_id: instagram.id)
  end

  has_many :comment_likes, dependent: :destroy
  has_many :comment_liked_comments, through: :likes, source: :comment
  def already_comment_liked?(comment)
    self.comment_likes.exists?(comment_id: comment.id)
  end
end
