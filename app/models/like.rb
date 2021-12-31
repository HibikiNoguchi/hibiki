class Like < ApplicationRecord
  belongs_to :instagram
  belongs_to :user

  validates_uniqueness_of :instagram_id, scope: :user_id
end
