class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :topics, dependent: :destroy

  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

#他人をフォローする
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

#他人をフォロー解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

#フォローしているかどうかを確認する。
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

#相互フォロー
  def friend
    followers && followed_users
  end

end
