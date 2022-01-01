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

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

end
